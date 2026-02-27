pub const LifecyclePolicyPreviewStatus = enum {
    in_progress,
    complete,
    expired,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .expired = "EXPIRED",
        .failed = "FAILED",
    };
};
