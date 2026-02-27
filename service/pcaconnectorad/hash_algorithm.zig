pub const HashAlgorithm = enum {
    sha256,
    sha384,
    sha512,

    pub const json_field_names = .{
        .sha256 = "SHA256",
        .sha384 = "SHA384",
        .sha512 = "SHA512",
    };
};
