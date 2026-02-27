pub const AutoMountHomeEFS = enum {
    enabled,
    disabled,
    default_as_domain,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .default_as_domain = "DEFAULT_AS_DOMAIN",
    };
};
