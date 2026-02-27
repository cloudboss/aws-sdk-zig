/// Disable this setting only when your workflow requires the
/// #EXT-X-ALLOW-CACHE:no tag. Otherwise, keep the default value Enabled and
/// control caching in your video distribution set up. For example, use the
/// Cache-Control http header.
pub const HlsClientCache = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
