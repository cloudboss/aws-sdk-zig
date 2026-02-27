/// The DataSync agents that can connect to your Network File System (NFS)
/// file server.
pub const OnPremConfig = struct {
    /// The Amazon Resource Names (ARNs) of the DataSync agents that can connect to
    /// your NFS file server.
    ///
    /// You can specify more than one agent. For more information, see [Using
    /// multiple DataSync
    /// agents](https://docs.aws.amazon.com/datasync/latest/userguide/do-i-need-datasync-agent.html#multiple-agents).
    agent_arns: []const []const u8,

    pub const json_field_names = .{
        .agent_arns = "AgentArns",
    };
};
