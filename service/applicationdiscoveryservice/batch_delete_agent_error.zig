const DeleteAgentErrorCode = @import("delete_agent_error_code.zig").DeleteAgentErrorCode;

/// An object representing the agent or data collector that failed to delete,
/// each containing agentId,
/// errorMessage, and errorCode.
pub const BatchDeleteAgentError = struct {
    /// The ID of the agent or data collector to delete.
    agent_id: []const u8,

    /// The type of error that occurred for the delete failed agent.
    /// Valid status are: AGENT_IN_USE | NOT_FOUND | INTERNAL_SERVER_ERROR.
    error_code: DeleteAgentErrorCode,

    /// The description of the error that occurred for the delete failed agent.
    error_message: []const u8,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
