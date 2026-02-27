pub const StabilityStatus = enum {
    steady_state,
    stabilizing,

    pub const json_field_names = .{
        .steady_state = "STEADY_STATE",
        .stabilizing = "STABILIZING",
    };
};
