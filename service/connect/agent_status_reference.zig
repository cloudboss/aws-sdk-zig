/// Information about the agent's status.
pub const AgentStatusReference = struct {
    /// The Amazon Resource Name (ARN) of the agent's status.
    status_arn: ?[]const u8,

    /// The name of the agent status.
    status_name: ?[]const u8,

    /// The start timestamp of the agent's status.
    status_start_timestamp: ?i64,

    pub const json_field_names = .{
        .status_arn = "StatusArn",
        .status_name = "StatusName",
        .status_start_timestamp = "StatusStartTimestamp",
    };
};
