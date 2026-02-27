pub const JobStatus = enum {
    pending,
    started,
    completed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .started = "STARTED",
        .completed = "COMPLETED",
    };
};
