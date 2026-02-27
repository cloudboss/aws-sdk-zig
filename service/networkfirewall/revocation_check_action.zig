pub const RevocationCheckAction = enum {
    pass,
    drop,
    reject,

    pub const json_field_names = .{
        .pass = "PASS",
        .drop = "DROP",
        .reject = "REJECT",
    };
};
