const std = @import("std");

/// Specifies the media type of the thumbnail.
pub const ContentType = enum {
    image_jpeg,

    pub const json_field_names = .{
        .image_jpeg = "image/jpeg",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .image_jpeg => "image/jpeg",
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
