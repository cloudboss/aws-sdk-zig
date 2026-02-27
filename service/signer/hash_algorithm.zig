pub const HashAlgorithm = enum {
    sha1,
    sha256,

    pub const json_field_names = .{
        .sha1 = "SHA1",
        .sha256 = "SHA256",
    };
};
