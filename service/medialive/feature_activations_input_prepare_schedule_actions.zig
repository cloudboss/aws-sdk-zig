/// Feature Activations Input Prepare Schedule Actions
pub const FeatureActivationsInputPrepareScheduleActions = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
