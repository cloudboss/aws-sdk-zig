/// A summary of an agent, including its identifier, name, and metadata.
pub const AgentSummary = struct {
    /// The unique identifier for the agent.
    agent_id: []const u8,

    /// The Amazon Resource Name (ARN) of the agent.
    arn: []const u8,

    /// The date and time that the agent was created.
    created_at: i64,

    /// A description of the agent.
    description: ?[]const u8 = null,

    /// The icon identifier for the agent.
    icon_id: ?[]const u8 = null,

    /// The name of the agent.
    name: []const u8,

    /// The date and time that the agent was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .agent_id = "AgentId",
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .icon_id = "IconId",
        .name = "Name",
        .updated_at = "UpdatedAt",
    };
};
