pub const CredentialsScope = enum {
    read,
    readwrite,

    pub const json_field_names = .{
        .read = "READ",
        .readwrite = "READWRITE",
    };
};
