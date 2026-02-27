pub const AgentCollaboration = enum {
    supervisor,
    supervisor_router,
    disabled,

    pub const json_field_names = .{
        .supervisor = "SUPERVISOR",
        .supervisor_router = "SUPERVISOR_ROUTER",
        .disabled = "DISABLED",
    };
};
