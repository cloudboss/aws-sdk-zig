pub const DashPeriodTrigger = enum {
    avails,
    drm_key_rotation,
    source_changes,
    source_disruptions,
    none,

    pub const json_field_names = .{
        .avails = "AVAILS",
        .drm_key_rotation = "DRM_KEY_ROTATION",
        .source_changes = "SOURCE_CHANGES",
        .source_disruptions = "SOURCE_DISRUPTIONS",
        .none = "NONE",
    };
};
