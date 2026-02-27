pub const OperationStatus = enum {
    submitted,
    pending,
    success,
    fail,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .pending = "PENDING",
        .success = "SUCCESS",
        .fail = "FAIL",
    };
};
