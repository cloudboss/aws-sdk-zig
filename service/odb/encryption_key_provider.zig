const std = @import("std");

pub const EncryptionKeyProvider = enum {
    oracle_managed,
    aws_kms,
    okv,
    oci,

    pub const json_field_names = .{
        .oracle_managed = "ORACLE_MANAGED",
        .aws_kms = "AWS_KMS",
        .okv = "OKV",
        .oci = "OCI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .oracle_managed => "ORACLE_MANAGED",
            .aws_kms => "AWS_KMS",
            .okv => "OKV",
            .oci => "OCI",
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
