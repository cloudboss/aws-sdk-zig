pub const JSModule = enum {
    es2020,
    esnext,

    pub const json_field_names = .{
        .es2020 = "ES2020",
        .esnext = "ESNEXT",
    };
};
