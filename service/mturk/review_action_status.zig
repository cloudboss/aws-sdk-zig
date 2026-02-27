pub const ReviewActionStatus = enum {
    intended,
    succeeded,
    failed,
    cancelled,

    pub const json_field_names = .{
        .intended = "Intended",
        .succeeded = "Succeeded",
        .failed = "Failed",
        .cancelled = "Cancelled",
    };
};
