pub const MdnSigningAlg = enum {
    sha256,
    sha384,
    sha512,
    sha1,
    none,
    default,

    pub const json_field_names = .{
        .sha256 = "SHA256",
        .sha384 = "SHA384",
        .sha512 = "SHA512",
        .sha1 = "SHA1",
        .none = "NONE",
        .default = "DEFAULT",
    };
};
