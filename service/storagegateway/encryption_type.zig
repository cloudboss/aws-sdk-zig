const std = @import("std");

pub const EncryptionType = enum {
    sse_s3,
    sse_kms,
    dsse_kms,

    pub const json_field_names = .{
        .sse_s3 = "SseS3",
        .sse_kms = "SseKms",
        .dsse_kms = "DsseKms",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sse_s3 => "SseS3",
            .sse_kms => "SseKms",
            .dsse_kms => "DsseKms",
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
