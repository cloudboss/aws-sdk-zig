pub const ExecutorType = enum {
    job_worker,
    lambda,

    pub const json_field_names = .{
        .job_worker = "JobWorker",
        .lambda = "Lambda",
    };
};
