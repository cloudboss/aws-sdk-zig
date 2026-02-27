/// Enable Denoise to filter noise from the input. Default is disabled. Only
/// applicable to MPEG2, H.264, H.265, and uncompressed video inputs.
pub const InputDenoiseFilter = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
