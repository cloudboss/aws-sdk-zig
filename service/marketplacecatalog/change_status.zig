pub const ChangeStatus = enum {
    preparing,
    applying,
    succeeded,
    cancelled,
    failed,

    pub const json_field_names = .{
        .preparing = "PREPARING",
        .applying = "APPLYING",
        .succeeded = "SUCCEEDED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };
};
