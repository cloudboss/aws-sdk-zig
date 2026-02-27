pub const DedicatedTenancyModificationStateEnum = enum {
    pending,
    completed,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
