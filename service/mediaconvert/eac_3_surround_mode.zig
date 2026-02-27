/// When encoding 2/0 audio, sets whether Dolby Surround is matrix encoded into
/// the two channels.
pub const Eac3SurroundMode = enum {
    not_indicated,
    enabled,
    disabled,

    pub const json_field_names = .{
        .not_indicated = "NOT_INDICATED",
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
