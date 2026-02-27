pub const ScalingAdjustmentType = enum {
    change_in_capacity,
    exact_capacity,
    percent_change_in_capacity,

    pub const json_field_names = .{
        .change_in_capacity = "ChangeInCapacity",
        .exact_capacity = "ExactCapacity",
        .percent_change_in_capacity = "PercentChangeInCapacity",
    };
};
