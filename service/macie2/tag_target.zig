const std = @import("std");

/// The type of object to apply a tag-based condition to. Valid values are:
pub const TagTarget = enum {
    s3_object,

    pub const json_field_names = .{
        .s3_object = "S3_OBJECT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s3_object => "S3_OBJECT",
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
