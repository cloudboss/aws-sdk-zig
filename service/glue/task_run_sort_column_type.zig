pub const TaskRunSortColumnType = enum {
    task_run_type,
    status,
    started,

    pub const json_field_names = .{
        .task_run_type = "TASK_RUN_TYPE",
        .status = "STATUS",
        .started = "STARTED",
    };
};
