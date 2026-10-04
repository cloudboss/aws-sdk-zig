const std = @import("std");

/// The HTTP Accept header. Indicates the requested type fothe thumbnail.
pub const AcceptHeader = enum {
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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
