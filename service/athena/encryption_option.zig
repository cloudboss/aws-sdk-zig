const std = @import("std");

pub const EncryptionOption = enum {
    sse_s3,
    sse_kms,
    cse_kms,

    pub const json_field_names = .{
        .sse_s3 = "SSE_S3",
        .sse_kms = "SSE_KMS",
        .cse_kms = "CSE_KMS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sse_s3 => "SSE_S3",
            .sse_kms => "SSE_KMS",
            .cse_kms => "CSE_KMS",
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
