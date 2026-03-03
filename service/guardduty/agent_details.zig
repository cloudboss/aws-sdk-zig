/// Information about the installed GuardDuty security agent.
pub const AgentDetails = struct {
    /// Version of the installed GuardDuty security agent.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .version = "Version",
    };
};
