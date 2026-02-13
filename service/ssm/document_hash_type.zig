pub const DocumentHashType = enum {
    sha256,
    sha1,

    pub const json_field_names = .{
        .sha256 = "SHA256",
        .sha1 = "SHA1",
    };
};
