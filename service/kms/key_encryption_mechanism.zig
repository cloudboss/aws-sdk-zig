pub const KeyEncryptionMechanism = enum {
    rsaes_oaep_sha_256,

    pub const json_field_names = .{
        .rsaes_oaep_sha_256 = "RSAES_OAEP_SHA_256",
    };
};
