const std = @import("std");

pub const KmsGrantOperation = enum {
    create_grant,
    decrypt,
    describe_key,
    encrypt,
    generate_data_key,
    generate_data_key_pair,
    generate_data_key_pair_without_plaintext,
    generate_data_key_without_plaintext,
    get_public_key,
    reencrypt_from,
    reencrypt_to,
    retire_grant,
    sign,
    verify,

    pub const json_field_names = .{
        .create_grant = "CreateGrant",
        .decrypt = "Decrypt",
        .describe_key = "DescribeKey",
        .encrypt = "Encrypt",
        .generate_data_key = "GenerateDataKey",
        .generate_data_key_pair = "GenerateDataKeyPair",
        .generate_data_key_pair_without_plaintext = "GenerateDataKeyPairWithoutPlaintext",
        .generate_data_key_without_plaintext = "GenerateDataKeyWithoutPlaintext",
        .get_public_key = "GetPublicKey",
        .reencrypt_from = "ReEncryptFrom",
        .reencrypt_to = "ReEncryptTo",
        .retire_grant = "RetireGrant",
        .sign = "Sign",
        .verify = "Verify",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_grant => "CreateGrant",
            .decrypt => "Decrypt",
            .describe_key => "DescribeKey",
            .encrypt => "Encrypt",
            .generate_data_key => "GenerateDataKey",
            .generate_data_key_pair => "GenerateDataKeyPair",
            .generate_data_key_pair_without_plaintext => "GenerateDataKeyPairWithoutPlaintext",
            .generate_data_key_without_plaintext => "GenerateDataKeyWithoutPlaintext",
            .get_public_key => "GetPublicKey",
            .reencrypt_from => "ReEncryptFrom",
            .reencrypt_to => "ReEncryptTo",
            .retire_grant => "RetireGrant",
            .sign => "Sign",
            .verify => "Verify",
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
