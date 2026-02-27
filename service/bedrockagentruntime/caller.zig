/// Details about a caller.
pub const Caller = union(enum) {
    /// The caller's agent alias ARN.
    agent_alias_arn: ?[]const u8,

    pub const json_field_names = .{
        .agent_alias_arn = "agentAliasArn",
    };
};
