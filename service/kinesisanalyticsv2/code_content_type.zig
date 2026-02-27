pub const CodeContentType = enum {
    plaintext,
    zipfile,

    pub const json_field_names = .{
        .plaintext = "PLAINTEXT",
        .zipfile = "ZIPFILE",
    };
};
