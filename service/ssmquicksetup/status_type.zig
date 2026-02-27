pub const StatusType = enum {
    deployment,
    async_executions,

    pub const json_field_names = .{
        .deployment = "DEPLOYMENT",
        .async_executions = "ASYNC_EXECUTIONS",
    };
};
