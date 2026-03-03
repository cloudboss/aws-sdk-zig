const std = @import("std");

pub const EncryptionModeValue = enum {
    sse_s3,
    sse_kms,

    pub const json_field_names = .{
        .sse_s3 = "sse-s3",
        .sse_kms = "sse-kms",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sse_s3 => "sse-s3",
            .sse_kms => "sse-kms",
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
