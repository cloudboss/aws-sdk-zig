pub const AutoScalingStatus = enum {
    growing,
    steady,
    shrinking,

    pub const json_field_names = .{
        .growing = "GROWING",
        .steady = "STEADY",
        .shrinking = "SHRINKING",
    };
};
