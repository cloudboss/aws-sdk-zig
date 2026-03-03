const std = @import("std");

pub const MediaType = enum {
    image_logo_light_favicon,
    image_logo_dark_favicon,
    image_logo_light_horizontal,
    image_logo_dark_horizontal,

    pub const json_field_names = .{
        .image_logo_light_favicon = "IMAGE_LOGO_LIGHT_FAVICON",
        .image_logo_dark_favicon = "IMAGE_LOGO_DARK_FAVICON",
        .image_logo_light_horizontal = "IMAGE_LOGO_LIGHT_HORIZONTAL",
        .image_logo_dark_horizontal = "IMAGE_LOGO_DARK_HORIZONTAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .image_logo_light_favicon => "IMAGE_LOGO_LIGHT_FAVICON",
            .image_logo_dark_favicon => "IMAGE_LOGO_DARK_FAVICON",
            .image_logo_light_horizontal => "IMAGE_LOGO_LIGHT_HORIZONTAL",
            .image_logo_dark_horizontal => "IMAGE_LOGO_DARK_HORIZONTAL",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
