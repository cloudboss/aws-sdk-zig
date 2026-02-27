/// When encoding 3/2 audio, sets whether an extra center back surround channel
/// is matrix encoded into the left and right surround channels.
pub const Eac3SurroundExMode = enum {
    not_indicated,
    enabled,
    disabled,

    pub const json_field_names = .{
        .not_indicated = "NOT_INDICATED",
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
