pub const KeyUsageType = enum {
    sign_verify,
    encrypt_decrypt,
    generate_verify_mac,
    key_agreement,

    pub const json_field_names = .{
        .sign_verify = "SIGN_VERIFY",
        .encrypt_decrypt = "ENCRYPT_DECRYPT",
        .generate_verify_mac = "GENERATE_VERIFY_MAC",
        .key_agreement = "KEY_AGREEMENT",
    };
};
