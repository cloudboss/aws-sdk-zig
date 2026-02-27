pub const LivenessSessionStatus = enum {
    created,
    in_progress,
    succeeded,
    failed,
    expired,

    pub const json_field_names = .{
        .created = "CREATED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .expired = "EXPIRED",
    };
};
