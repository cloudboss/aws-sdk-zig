pub const AdjustmentType = enum {
    change_in_capacity,
    percent_change_in_capacity,
    exact_capacity,

    pub const json_field_names = .{
        .change_in_capacity = "CHANGE_IN_CAPACITY",
        .percent_change_in_capacity = "PERCENT_CHANGE_IN_CAPACITY",
        .exact_capacity = "EXACT_CAPACITY",
    };
};
