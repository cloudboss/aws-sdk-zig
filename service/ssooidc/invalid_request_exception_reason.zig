pub const InvalidRequestExceptionReason = enum {
    kms_key_not_found,
    kms_invalid_key_usage,
    kms_invalid_state,
    kms_disabled_key,

    pub const json_field_names = .{
        .kms_key_not_found = "KMS_KEY_NOT_FOUND",
        .kms_invalid_key_usage = "KMS_INVALID_KEY_USAGE",
        .kms_invalid_state = "KMS_INVALID_STATE",
        .kms_disabled_key = "KMS_DISABLED_KEY",
    };
};
