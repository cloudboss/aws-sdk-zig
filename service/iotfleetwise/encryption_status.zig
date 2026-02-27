pub const EncryptionStatus = enum {
    pending,
    success,
    failure,

    pub const json_field_names = .{
        .pending = "PENDING",
        .success = "SUCCESS",
        .failure = "FAILURE",
    };
};
