const std = @import("std");

pub const AssetExtensionType = enum {
    ico,
    jpeg,
    png,
    svg,
    webp,

    pub const json_field_names = .{
        .ico = "ICO",
        .jpeg = "JPEG",
        .png = "PNG",
        .svg = "SVG",
        .webp = "WEBP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ico => "ICO",
            .jpeg => "JPEG",
            .png => "PNG",
            .svg => "SVG",
            .webp => "WEBP",
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
