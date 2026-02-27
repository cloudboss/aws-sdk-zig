pub const EvaluationFormItemSourceValuesComparator = enum {
    in,
    not_in,
    all_in,
    exact,

    pub const json_field_names = .{
        .in = "IN",
        .not_in = "NOT_IN",
        .all_in = "ALL_IN",
        .exact = "EXACT",
    };
};
