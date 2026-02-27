pub const SageMakerResourceName = enum {
    training_job,
    hyperpod_cluster,
    endpoint,

    pub const json_field_names = .{
        .training_job = "TRAINING_JOB",
        .hyperpod_cluster = "HYPERPOD_CLUSTER",
        .endpoint = "ENDPOINT",
    };
};
