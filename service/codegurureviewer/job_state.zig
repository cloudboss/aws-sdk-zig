pub const JobState = enum {
    completed,
    pending,
    failed,
    deleting,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .pending = "PENDING",
        .failed = "FAILED",
        .deleting = "DELETING",
    };
};
