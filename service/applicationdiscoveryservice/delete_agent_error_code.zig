pub const DeleteAgentErrorCode = enum {
    not_found,
    internal_server_error,
    agent_in_use,

    pub const json_field_names = .{
        .not_found = "NOT_FOUND",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
        .agent_in_use = "AGENT_IN_USE",
    };
};
