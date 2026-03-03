const AsyncInferenceNotificationConfig = @import("async_inference_notification_config.zig").AsyncInferenceNotificationConfig;

/// Specifies the configuration for asynchronous inference invocation outputs.
pub const AsyncInferenceOutputConfig = struct {
    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that SageMaker uses to encrypt the asynchronous inference output in Amazon
    /// S3.
    kms_key_id: ?[]const u8 = null,

    /// Specifies the configuration for notifications of inference results for
    /// asynchronous inference.
    notification_config: ?AsyncInferenceNotificationConfig = null,

    /// The Amazon S3 location to upload failure inference responses to.
    s3_failure_path: ?[]const u8 = null,

    /// The Amazon S3 location to upload inference responses to.
    s3_output_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .notification_config = "NotificationConfig",
        .s3_failure_path = "S3FailurePath",
        .s3_output_path = "S3OutputPath",
    };
};
