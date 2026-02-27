const CreatorModeControl = @import("creator_mode_control.zig").CreatorModeControl;

/// Configuration information required to invoke chat in `CREATOR_MODE`.
///
/// For more information, see [Admin controls and
/// guardrails](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/guardrails.html) and [Conversation settings](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/using-web-experience.html#chat-source-scope).
pub const CreatorModeConfiguration = struct {
    /// Status information about whether `CREATOR_MODE` has been enabled or
    /// disabled. The default status is `DISABLED`.
    creator_mode_control: CreatorModeControl,

    pub const json_field_names = .{
        .creator_mode_control = "creatorModeControl",
    };
};
