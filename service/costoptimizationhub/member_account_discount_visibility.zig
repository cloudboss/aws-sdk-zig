pub const MemberAccountDiscountVisibility = enum {
    all,
    none,

    pub const json_field_names = .{
        .all = "ALL",
        .none = "NONE",
    };
};
