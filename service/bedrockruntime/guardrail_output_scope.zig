pub const GuardrailOutputScope = enum {
    interventions,
    full,

    pub const json_field_names = .{
        .interventions = "INTERVENTIONS",
        .full = "FULL",
    };
};
