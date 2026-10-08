const std = @import("std");

/// Type of brand profile attribute. Drives whether a value is inline (TEXT)
/// or referenced via a presigned media upload URL.
pub const BrandProfileAttributeType = enum {
    text,
    image,
    document,

    pub const json_field_names = .{
        .text = "TEXT",
        .image = "IMAGE",
        .document = "DOCUMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text => "TEXT",
            .image => "IMAGE",
            .document => "DOCUMENT",
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
