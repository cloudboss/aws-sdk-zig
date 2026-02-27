/// Enable Deblock to produce smoother motion in the output. Default is
/// disabled. Only manually controllable for MPEG2 and uncompressed video
/// inputs.
pub const InputDeblockFilter = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
