/*
 *   -- http://android-fb2png.googlecode.com/svn/trunk/img_process.c --
 *
 *   Copyright 2011, Kyan He <kyan.ql.he@gmail.com>
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <errno.h>
#include <png.h>
#include "img_process.h"
#include "log.h"

static void
stdio_write_func(png_structp png, png_bytep data, png_size_t size)
{
    FILE *fp;
    size_t ret;

    fp = png_get_io_ptr(png);
    while (size) {
        ret = fwrite(data, 1, size, fp);
        size -= ret;
        data += ret;
        if (size && ferror(fp))
            E("write: %m\n");
    }
}

static void
png_simple_output_flush_fn(__attribute__((unused)) png_structp png_ptr)
{
}

static void
png_simple_error_callback(__attribute__((unused)) png_structp png_ptr, const char* message)
{
    E("png error: %s\n", message);
}

int save_png(const char* path, const raw_image_t* img)
{
    FILE *fp;
    png_structp png;
    png_infop info;
    png_bytep row;
    int y;

    fp = fopen(path, "wb");
    if (!fp) {
        E("Failed to open file %s: %m\n", path);
        return -1;
    }

    png = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, png_simple_error_callback, NULL);
    if (!png) {
        fclose(fp);
        E("Failed to create png write struct\n");
        return -1;
    }

    info = png_create_info_struct(png);
    if (!info) {
        png_destroy_write_struct(&png, NULL);
        fclose(fp);
        E("Failed to create png info struct\n");
        return -1;
    }

    png_set_write_fn(png, fp, stdio_write_func, png_simple_output_flush_fn);

    png_set_IHDR(png, info, img->width, img->height, 8, PNG_COLOR_TYPE_RGB,
                 PNG_INTERLACE_NONE, PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT);

    png_write_info(png, info);

    for (y = 0; y < img->height; ++y) {
        row = (png_bytep)(img->data + y * img->width * 3); // Trabaja con los datos tal como están
        png_write_row(png, row);
    }

    png_write_end(png, NULL);
    png_destroy_write_struct(&png, &info);
    fclose(fp);

    return 0;
}