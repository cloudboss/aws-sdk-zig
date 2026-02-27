pub const SMBSecurityStrategy = enum {
    client_specified,
    mandatory_signing,
    mandatory_encryption,
    mandatory_encryption_no_aes_128,

    pub const json_field_names = .{
        .client_specified = "ClientSpecified",
        .mandatory_signing = "MandatorySigning",
        .mandatory_encryption = "MandatoryEncryption",
        .mandatory_encryption_no_aes_128 = "MandatoryEncryptionNoAes128",
    };
};
