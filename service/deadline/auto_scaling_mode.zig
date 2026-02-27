pub const AutoScalingMode = enum {
    no_scaling,
    event_based_auto_scaling,

    pub const json_field_names = .{
        .no_scaling = "NO_SCALING",
        .event_based_auto_scaling = "EVENT_BASED_AUTO_SCALING",
    };
};
