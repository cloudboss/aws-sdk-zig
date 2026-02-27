pub const ValidationExceptionReason = enum {
    kms_invalid_key_usage_exception,
    kms_invalid_state_exception,
    kms_disabled_exception,

    pub const json_field_names = .{
        .kms_invalid_key_usage_exception = "KMS_INVALID_KEY_USAGE_EXCEPTION",
        .kms_invalid_state_exception = "KMS_INVALID_STATE_EXCEPTION",
        .kms_disabled_exception = "KMS_DISABLED_EXCEPTION",
    };
};
