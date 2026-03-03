const Platform = @import("platform.zig").Platform;
const AgentStatus = @import("agent_status.zig").AgentStatus;

/// Represents a single entry in a list (or array) of DataSync agents when
/// you call the
/// [ListAgents](https://docs.aws.amazon.com/datasync/latest/userguide/API_ListAgents.html) operation.
pub const AgentListEntry = struct {
    /// The Amazon Resource Name (ARN) of a DataSync agent.
    agent_arn: ?[]const u8 = null,

    /// The name of an agent.
    name: ?[]const u8 = null,

    /// The platform-related details about the agent, such as the version number.
    platform: ?Platform = null,

    /// The status of an agent.
    ///
    /// * If the status is `ONLINE`, the agent is configured properly and ready to
    /// use.
    ///
    /// * If the status is `OFFLINE`, the agent has been out of contact with
    /// DataSync for five minutes or longer. This can happen for a few reasons. For
    /// more information, see [What do I do if my agent is
    /// offline?](https://docs.aws.amazon.com/datasync/latest/userguide/troubleshooting-datasync-agents.html#troubleshoot-agent-offline)
    status: ?AgentStatus = null,

    pub const json_field_names = .{
        .agent_arn = "AgentArn",
        .name = "Name",
        .platform = "Platform",
        .status = "Status",
    };
};
