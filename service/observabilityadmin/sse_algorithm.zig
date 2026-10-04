const std = @import("std");

pub const SSEAlgorithm = enum {
    sse_kms,
    sse_s3,

    pub const json_field_names = .{
        .sse_kms = "aws:kms",
        .sse_s3 = "AES256",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sse_kms => "aws:kms",
            .sse_s3 => "AES256",
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
