/// Enable this setting when you run a test job to estimate how many reserved
/// transcoding slots (RTS) you need. When this is enabled, MediaConvert runs
/// your job from an on-demand queue with similar performance to what you will
/// see with one RTS in a reserved queue. This setting is disabled by default.
pub const SimulateReservedQueue = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
