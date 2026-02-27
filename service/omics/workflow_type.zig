pub const WorkflowType = enum {
    private,
    ready2_run,

    pub const json_field_names = .{
        .private = "PRIVATE",
        .ready2_run = "READY2RUN",
    };
};
