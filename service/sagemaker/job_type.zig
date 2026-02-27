pub const JobType = enum {
    training,
    inference,
    notebook_kernel,

    pub const json_field_names = .{
        .training = "TRAINING",
        .inference = "INFERENCE",
        .notebook_kernel = "NOTEBOOK_KERNEL",
    };
};
