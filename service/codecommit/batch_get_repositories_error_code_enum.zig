pub const BatchGetRepositoriesErrorCodeEnum = enum {
    encryption_integrity_checks_failed_exception,
    encryption_key_access_denied_exception,
    encryption_key_disabled_exception,
    encryption_key_not_found_exception,
    encryption_key_unavailable_exception,
    repository_does_not_exist_exception,

    pub const json_field_names = .{
        .encryption_integrity_checks_failed_exception = "ENCRYPTION_INTEGRITY_CHECKS_FAILED_EXCEPTION",
        .encryption_key_access_denied_exception = "ENCRYPTION_KEY_ACCESS_DENIED_EXCEPTION",
        .encryption_key_disabled_exception = "ENCRYPTION_KEY_DISABLED_EXCEPTION",
        .encryption_key_not_found_exception = "ENCRYPTION_KEY_NOT_FOUND_EXCEPTION",
        .encryption_key_unavailable_exception = "ENCRYPTION_KEY_UNAVAILABLE_EXCEPTION",
        .repository_does_not_exist_exception = "REPOSITORY_DOES_NOT_EXIST_EXCEPTION",
    };
};
