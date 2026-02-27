pub const ValidationExceptionReason = enum {
    kms_invalid_arn,
    kms_invalid_key_usage,
    kms_invalid_state,
    kms_disabled,

    pub const json_field_names = .{
        .kms_invalid_arn = "KMS_INVALID_ARN",
        .kms_invalid_key_usage = "KMS_INVALID_KEY_USAGE",
        .kms_invalid_state = "KMS_INVALID_STATE",
        .kms_disabled = "KMS_DISABLED",
    };
};
