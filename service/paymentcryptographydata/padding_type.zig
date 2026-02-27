pub const PaddingType = enum {
    pkcs1,
    oaep_sha1,
    oaep_sha256,
    oaep_sha512,

    pub const json_field_names = .{
        .pkcs1 = "PKCS1",
        .oaep_sha1 = "OAEP_SHA1",
        .oaep_sha256 = "OAEP_SHA256",
        .oaep_sha512 = "OAEP_SHA512",
    };
};
