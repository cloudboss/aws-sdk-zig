/// Feature Activations Output Static Image Overlay Schedule Actions
pub const FeatureActivationsOutputStaticImageOverlayScheduleActions = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
