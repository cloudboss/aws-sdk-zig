pub const ShippingLabelStatus = enum {
    in_progress,
    timed_out,
    succeeded,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .timed_out = "TIMED_OUT",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
