/// Information about an agent.
pub const AgentAttributes = struct {
    /// The agent’s first name as entered in their Amazon Connect user account.
    first_name: ?[]const u8 = null,

    /// The agent’s last name as entered in their Amazon Connect user account.
    last_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .first_name = "firstName",
        .last_name = "lastName",
    };
};
