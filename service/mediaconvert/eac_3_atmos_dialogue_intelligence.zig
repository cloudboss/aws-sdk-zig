/// Enable Dolby Dialogue Intelligence to adjust loudness based on dialogue
/// analysis.
pub const Eac3AtmosDialogueIntelligence = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
