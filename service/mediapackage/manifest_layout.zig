pub const ManifestLayout = enum {
    full,
    compact,
    drm_top_level_compact,

    pub const json_field_names = .{
        .full = "FULL",
        .compact = "COMPACT",
        .drm_top_level_compact = "DRM_TOP_LEVEL_COMPACT",
    };
};
