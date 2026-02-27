pub const ReportingErrorCode = enum {
    internal_error,
    invalid_permissions,
    no_findings_found,
    bucket_not_found,
    incompatible_bucket_region,
    malformed_kms_key,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .invalid_permissions = "INVALID_PERMISSIONS",
        .no_findings_found = "NO_FINDINGS_FOUND",
        .bucket_not_found = "BUCKET_NOT_FOUND",
        .incompatible_bucket_region = "INCOMPATIBLE_BUCKET_REGION",
        .malformed_kms_key = "MALFORMED_KMS_KEY",
    };
};
