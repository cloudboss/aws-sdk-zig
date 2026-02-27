pub const SessionStatus = enum {
    pending,
    cancelled,
    approved,
    failed,
    creating,

    pub const json_field_names = .{
        .pending = "PENDING",
        .cancelled = "CANCELLED",
        .approved = "APPROVED",
        .failed = "FAILED",
        .creating = "CREATING",
    };
};
