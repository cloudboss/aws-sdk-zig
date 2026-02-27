pub const NotificationType = enum {
    lens_version_upgraded,
    lens_version_deprecated,

    pub const json_field_names = .{
        .lens_version_upgraded = "LENS_VERSION_UPGRADED",
        .lens_version_deprecated = "LENS_VERSION_DEPRECATED",
    };
};
