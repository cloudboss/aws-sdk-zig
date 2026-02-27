pub const MacAlgorithm = enum {
    iso9797_algorithm1,
    iso9797_algorithm3,
    cmac,
    hmac,
    hmac_sha224,
    hmac_sha256,
    hmac_sha384,
    hmac_sha512,
    as2805_4_1,

    pub const json_field_names = .{
        .iso9797_algorithm1 = "ISO9797_ALGORITHM1",
        .iso9797_algorithm3 = "ISO9797_ALGORITHM3",
        .cmac = "CMAC",
        .hmac = "HMAC",
        .hmac_sha224 = "HMAC_SHA224",
        .hmac_sha256 = "HMAC_SHA256",
        .hmac_sha384 = "HMAC_SHA384",
        .hmac_sha512 = "HMAC_SHA512",
        .as2805_4_1 = "AS2805_4_1",
    };
};
