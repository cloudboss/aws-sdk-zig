pub const EncryptedLogGroupStrategy = enum {
    allow,
    skip,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .skip = "SKIP",
    };
};
