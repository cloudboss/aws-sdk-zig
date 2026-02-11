pub const ProvisionedConcurrencyStatusEnum = enum {
    in_progress,
    ready,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .ready = "READY",
        .failed = "FAILED",
    };
};
