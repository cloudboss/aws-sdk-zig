const AutomatedReasoningPolicyBuildMessageType = @import("automated_reasoning_policy_build_message_type.zig").AutomatedReasoningPolicyBuildMessageType;

/// Represents a message generated during a build step, providing information
/// about what happened or any issues encountered.
pub const AutomatedReasoningPolicyBuildStepMessage = struct {
    /// The content of the message, describing what occurred during the build step.
    message: []const u8,

    /// The type of message (e.g., INFO, WARNING, ERROR) indicating its severity and
    /// purpose.
    message_type: AutomatedReasoningPolicyBuildMessageType,

    pub const json_field_names = .{
        .message = "message",
        .message_type = "messageType",
    };
};
