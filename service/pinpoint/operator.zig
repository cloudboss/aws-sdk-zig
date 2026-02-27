pub const Operator = enum {
    all,
    any,

    pub const json_field_names = .{
        .all = "ALL",
        .any = "ANY",
    };
};
