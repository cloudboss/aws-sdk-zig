pub const AuthTypeValue = enum {
    no,
    password,

    pub const json_field_names = .{
        .no = "NO",
        .password = "PASSWORD",
    };
};
