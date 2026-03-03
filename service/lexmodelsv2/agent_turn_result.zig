const ExecutionErrorDetails = @import("execution_error_details.zig").ExecutionErrorDetails;

/// The information about the agent turn in a test set execution.
pub const AgentTurnResult = struct {
    /// The actual agent prompt for the agent turn in a test set execution.
    actual_agent_prompt: ?[]const u8 = null,

    /// The actual elicited slot for the agent turn in a test set execution.
    actual_elicited_slot: ?[]const u8 = null,

    /// The actual intent for the agent turn in a test set execution.
    actual_intent: ?[]const u8 = null,

    error_details: ?ExecutionErrorDetails = null,

    /// The expected agent prompt for the agent turn in a test set execution.
    expected_agent_prompt: []const u8,

    pub const json_field_names = .{
        .actual_agent_prompt = "actualAgentPrompt",
        .actual_elicited_slot = "actualElicitedSlot",
        .actual_intent = "actualIntent",
        .error_details = "errorDetails",
        .expected_agent_prompt = "expectedAgentPrompt",
    };
};
