pub const WirelessGatewayTaskStatus = enum {
    pending,
    in_progress,
    first_retry,
    second_retry,
    completed,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .first_retry = "FIRST_RETRY",
        .second_retry = "SECOND_RETRY",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
