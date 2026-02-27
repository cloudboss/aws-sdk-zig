pub const ExistCondition = enum {
    must_exist,
    not_exist,
    none,

    pub const json_field_names = .{
        .must_exist = "MUST_EXIST",
        .not_exist = "NOT_EXIST",
        .none = "NONE",
    };
};
