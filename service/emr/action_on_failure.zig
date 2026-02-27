pub const ActionOnFailure = enum {
    terminate_job_flow,
    terminate_cluster,
    cancel_and_wait,
    @"continue",

    pub const json_field_names = .{
        .terminate_job_flow = "TERMINATE_JOB_FLOW",
        .terminate_cluster = "TERMINATE_CLUSTER",
        .cancel_and_wait = "CANCEL_AND_WAIT",
        .@"continue" = "CONTINUE",
    };
};
