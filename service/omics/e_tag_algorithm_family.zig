pub const ETagAlgorithmFamily = enum {
    md5_up,
    sha256_up,
    sha512_up,

    pub const json_field_names = .{
        .md5_up = "MD5UP",
        .sha256_up = "SHA256UP",
        .sha512_up = "SHA512UP",
    };
};
