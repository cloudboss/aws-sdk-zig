pub const HashAlgorithm = enum {
    md5,
    sha1,
    sha256,
    sha512,

    pub const json_field_names = .{
        .md5 = "MD5",
        .sha1 = "SHA1",
        .sha256 = "SHA256",
        .sha512 = "SHA512",
    };
};
