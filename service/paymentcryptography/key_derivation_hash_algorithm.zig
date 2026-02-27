pub const KeyDerivationHashAlgorithm = enum {
    sha_256,
    sha_384,
    sha_512,

    pub const json_field_names = .{
        .sha_256 = "SHA_256",
        .sha_384 = "SHA_384",
        .sha_512 = "SHA_512",
    };
};
