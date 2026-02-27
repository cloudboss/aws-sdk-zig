pub const AdjustmentType = enum {
    change_in_capacity,
    percent_change_in_capacity,
    exact_capacity,

    pub const json_field_names = .{
        .change_in_capacity = "ChangeInCapacity",
        .percent_change_in_capacity = "PercentChangeInCapacity",
        .exact_capacity = "ExactCapacity",
    };
};
