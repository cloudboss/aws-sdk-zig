/// When set to ENABLED, a DASH MPD manifest will be generated for this output.
pub const CmafWriteDASHManifest = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
