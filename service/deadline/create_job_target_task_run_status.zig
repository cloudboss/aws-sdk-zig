pub const CreateJobTargetTaskRunStatus = enum {
    ready,
    suspended,

    pub const json_field_names = .{
        .ready = "READY",
        .suspended = "SUSPENDED",
    };
};
