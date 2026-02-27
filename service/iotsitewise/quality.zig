pub const Quality = enum {
    good,
    bad,
    uncertain,

    pub const json_field_names = .{
        .good = "GOOD",
        .bad = "BAD",
        .uncertain = "UNCERTAIN",
    };
};
