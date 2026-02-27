/// Places a PPS header on each encoded picture, even if repeated.
pub const H264RepeatPps = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
