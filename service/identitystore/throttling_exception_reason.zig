pub const ThrottlingExceptionReason = enum {
    kms_throttling,

    pub const json_field_names = .{
        .kms_throttling = "KMS_THROTTLING",
    };
};
