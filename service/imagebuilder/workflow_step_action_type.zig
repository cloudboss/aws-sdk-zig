pub const WorkflowStepActionType = enum {
    @"resume",
    stop,

    pub const json_field_names = .{
        .@"resume" = "RESUME",
        .stop = "STOP",
    };
};
