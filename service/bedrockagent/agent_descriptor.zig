/// An agent descriptor.
pub const AgentDescriptor = struct {
    /// The agent's alias ARN.
    alias_arn: ?[]const u8,

    pub const json_field_names = .{
        .alias_arn = "aliasArn",
    };
};
