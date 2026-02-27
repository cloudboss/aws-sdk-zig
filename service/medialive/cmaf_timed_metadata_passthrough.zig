/// Cmaf Timed Metadata Passthrough
pub const CmafTimedMetadataPassthrough = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
