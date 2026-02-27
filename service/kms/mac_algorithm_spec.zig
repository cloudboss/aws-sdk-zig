pub const MacAlgorithmSpec = enum {
    hmac_sha_224,
    hmac_sha_256,
    hmac_sha_384,
    hmac_sha_512,

    pub const json_field_names = .{
        .hmac_sha_224 = "HMAC_SHA_224",
        .hmac_sha_256 = "HMAC_SHA_256",
        .hmac_sha_384 = "HMAC_SHA_384",
        .hmac_sha_512 = "HMAC_SHA_512",
    };
};
