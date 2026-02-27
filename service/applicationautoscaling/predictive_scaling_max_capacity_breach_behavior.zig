pub const PredictiveScalingMaxCapacityBreachBehavior = enum {
    honor_max_capacity,
    increase_max_capacity,

    pub const json_field_names = .{
        .honor_max_capacity = "HonorMaxCapacity",
        .increase_max_capacity = "IncreaseMaxCapacity",
    };
};
