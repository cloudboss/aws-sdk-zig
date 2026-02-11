pub const ReturnValuesOnConditionCheckFailure = enum {
    all_old,
    none,

    pub const json_field_names = .{
        .all_old = "ALL_OLD",
        .none = "NONE",
    };
};
