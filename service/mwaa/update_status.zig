pub const UpdateStatus = enum {
    success,
    pending,
    failed,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .pending = "PENDING",
        .failed = "FAILED",
    };
};
