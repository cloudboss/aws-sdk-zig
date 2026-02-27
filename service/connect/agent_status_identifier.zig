/// Information about the agent status assigned to the user.
pub const AgentStatusIdentifier = struct {
    /// The Amazon Resource Name (ARN) of the agent status.
    arn: ?[]const u8,

    /// The identifier of the agent status.
    id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};
