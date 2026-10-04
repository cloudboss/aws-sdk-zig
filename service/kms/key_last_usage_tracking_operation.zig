const std = @import("std");

pub const KeyLastUsageTrackingOperation = enum {
    decrypt,
    derive_shared_secret,
    encrypt,
    generate_data_key,
    generate_data_key_pair,
    generate_data_key_pair_without_plaintext,
    generate_data_key_without_plaintext,
    generate_mac,
    re_encrypt,
    sign,
    verify,
    verify_mac,

    pub const json_field_names = .{
        .decrypt = "Decrypt",
        .derive_shared_secret = "DeriveSharedSecret",
        .encrypt = "Encrypt",
        .generate_data_key = "GenerateDataKey",
        .generate_data_key_pair = "GenerateDataKeyPair",
        .generate_data_key_pair_without_plaintext = "GenerateDataKeyPairWithoutPlaintext",
        .generate_data_key_without_plaintext = "GenerateDataKeyWithoutPlaintext",
        .generate_mac = "GenerateMac",
        .re_encrypt = "ReEncrypt",
        .sign = "Sign",
        .verify = "Verify",
        .verify_mac = "VerifyMac",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .decrypt => "Decrypt",
            .derive_shared_secret => "DeriveSharedSecret",
            .encrypt => "Encrypt",
            .generate_data_key => "GenerateDataKey",
            .generate_data_key_pair => "GenerateDataKeyPair",
            .generate_data_key_pair_without_plaintext => "GenerateDataKeyPairWithoutPlaintext",
            .generate_data_key_without_plaintext => "GenerateDataKeyWithoutPlaintext",
            .generate_mac => "GenerateMac",
            .re_encrypt => "ReEncrypt",
            .sign => "Sign",
            .verify => "Verify",
            .verify_mac => "VerifyMac",
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
