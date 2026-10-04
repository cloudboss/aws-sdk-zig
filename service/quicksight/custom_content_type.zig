const std = @import("std");

pub const CustomContentType = enum {
    image,
    other_embedded_content,

    pub const json_field_names = .{
        .image = "IMAGE",
        .other_embedded_content = "OTHER_EMBEDDED_CONTENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .image => "IMAGE",
            .other_embedded_content => "OTHER_EMBEDDED_CONTENT",
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
