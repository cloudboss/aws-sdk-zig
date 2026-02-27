/// When set to ENABLED, an Apple HLS manifest will be generated for this
/// output.
pub const CmafWriteHLSManifest = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
