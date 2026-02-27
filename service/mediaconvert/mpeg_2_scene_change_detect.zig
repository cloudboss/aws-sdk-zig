/// Enable this setting to insert I-frames at scene changes that the service
/// automatically detects. This improves video quality and is enabled by
/// default.
pub const Mpeg2SceneChangeDetect = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
