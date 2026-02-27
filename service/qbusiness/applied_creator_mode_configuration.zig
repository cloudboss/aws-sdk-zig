const CreatorModeControl = @import("creator_mode_control.zig").CreatorModeControl;

/// The creator mode specific admin controls configured for an Amazon Q Business
/// application. Determines whether an end user can generate LLM-only responses
/// when they use the web experience.
///
/// For more information, see [Admin controls and
/// guardrails](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/guardrails.html) and [Conversation settings](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/using-web-experience.html#chat-source-scope).
pub const AppliedCreatorModeConfiguration = struct {
    /// Information about whether creator mode is enabled or disabled for an Amazon
    /// Q Business application.
    creator_mode_control: CreatorModeControl,

    pub const json_field_names = .{
        .creator_mode_control = "creatorModeControl",
    };
};
