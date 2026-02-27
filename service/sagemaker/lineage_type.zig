pub const LineageType = enum {
    trial_component,
    artifact,
    context,
    action,

    pub const json_field_names = .{
        .trial_component = "TRIAL_COMPONENT",
        .artifact = "ARTIFACT",
        .context = "CONTEXT",
        .action = "ACTION",
    };
};
