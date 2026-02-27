pub const RunAs = enum {
    queue_configured_user,
    worker_agent_user,

    pub const json_field_names = .{
        .queue_configured_user = "QUEUE_CONFIGURED_USER",
        .worker_agent_user = "WORKER_AGENT_USER",
    };
};
