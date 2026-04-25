const TestingAgentStatus = @import("testing_agent_status.zig").TestingAgentStatus;

/// Contains details about the testing agent associated with an RCS agent.
pub const TestingAgentInformation = struct {
    /// The unique identifier of the registration associated with the testing agent.
    registration_id: []const u8,

    /// The current status of the testing agent.
    status: TestingAgentStatus,

    /// The unique identifier for the testing agent.
    testing_agent_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .registration_id = "RegistrationId",
        .status = "Status",
        .testing_agent_id = "TestingAgentId",
    };
};
