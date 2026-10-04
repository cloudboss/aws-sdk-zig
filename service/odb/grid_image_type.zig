const std = @import("std");

pub const GridImageType = enum {
    /// A release update grid image.
    release_update,
    /// A custom grid image.
    custom_image,

    pub const json_field_names = .{
        .release_update = "RELEASE_UPDATE",
        .custom_image = "CUSTOM_IMAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .release_update => "RELEASE_UPDATE",
            .custom_image => "CUSTOM_IMAGE",
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
