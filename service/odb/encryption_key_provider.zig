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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
