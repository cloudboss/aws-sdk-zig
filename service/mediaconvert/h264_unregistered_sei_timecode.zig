/// Inserts timecode for each frame as 4 bytes of an unregistered SEI message.
pub const H264UnregisteredSeiTimecode = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
