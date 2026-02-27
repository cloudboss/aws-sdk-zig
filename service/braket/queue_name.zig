pub const QueueName = enum {
    quantum_tasks_queue,
    jobs_queue,

    pub const json_field_names = .{
        .quantum_tasks_queue = "QUANTUM_TASKS_QUEUE",
        .jobs_queue = "JOBS_QUEUE",
    };
};
