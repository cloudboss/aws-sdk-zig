pub const EndpointErrorCondition = enum {
    stale_manifest,
    incomplete_manifest,
    missing_drm_key,
    slate_input,

    pub const json_field_names = .{
        .stale_manifest = "STALE_MANIFEST",
        .incomplete_manifest = "INCOMPLETE_MANIFEST",
        .missing_drm_key = "MISSING_DRM_KEY",
        .slate_input = "SLATE_INPUT",
    };
};
