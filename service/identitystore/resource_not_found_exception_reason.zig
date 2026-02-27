pub const ResourceNotFoundExceptionReason = enum {
    kms_key_not_found,

    pub const json_field_names = .{
        .kms_key_not_found = "KMS_KEY_NOT_FOUND",
    };
};
