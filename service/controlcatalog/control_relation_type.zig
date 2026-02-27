pub const ControlRelationType = enum {
    complementary,
    alternative,
    mutually_exclusive,

    pub const json_field_names = .{
        .complementary = "COMPLEMENTARY",
        .alternative = "ALTERNATIVE",
        .mutually_exclusive = "MUTUALLY_EXCLUSIVE",
    };
};
