pub const MediaAnalysisJobFailureCode = enum {
    internal_error,
    invalid_s3_object,
    invalid_manifest,
    invalid_output_config,
    invalid_kms_key,
    access_denied,
    resource_not_found,
    resource_not_ready,
    throttled,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .invalid_s3_object = "INVALID_S3_OBJECT",
        .invalid_manifest = "INVALID_MANIFEST",
        .invalid_output_config = "INVALID_OUTPUT_CONFIG",
        .invalid_kms_key = "INVALID_KMS_KEY",
        .access_denied = "ACCESS_DENIED",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .resource_not_ready = "RESOURCE_NOT_READY",
        .throttled = "THROTTLED",
    };
};
