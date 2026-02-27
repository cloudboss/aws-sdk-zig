/// Hls Redundant Manifest
pub const HlsRedundantManifest = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
