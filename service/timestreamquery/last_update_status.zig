pub const LastUpdateStatus = enum {
    pending,
    failed,
    succeeded,

    pub const json_field_names = .{
        .pending = "PENDING",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
    };
};
