pub const AccessDeniedExceptionReason = enum {
    kms_access_denied,

    pub const json_field_names = .{
        .kms_access_denied = "KMS_ACCESS_DENIED",
    };
};
