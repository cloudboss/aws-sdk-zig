/// Represents information about the state of transitions between one stage and
/// another
/// stage.
pub const TransitionState = struct {
    /// The user-specified reason why the transition between two stages of a
    /// pipeline was
    /// disabled.
    disabled_reason: ?[]const u8,

    /// Whether the transition between stages is enabled (true) or disabled
    /// (false).
    enabled: bool = false,

    /// The timestamp when the transition state was last changed.
    last_changed_at: ?i64,

    /// The ID of the user who last changed the transition state.
    last_changed_by: ?[]const u8,

    pub const json_field_names = .{
        .disabled_reason = "disabledReason",
        .enabled = "enabled",
        .last_changed_at = "lastChangedAt",
        .last_changed_by = "lastChangedBy",
    };
};
