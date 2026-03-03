const AsyncNotificationTopicTypes = @import("async_notification_topic_types.zig").AsyncNotificationTopicTypes;

/// Specifies the configuration for notifications of inference results for
/// asynchronous inference.
pub const AsyncInferenceNotificationConfig = struct {
    /// Amazon SNS topic to post a notification to when inference fails. If no topic
    /// is provided, no notification is sent on failure.
    error_topic: ?[]const u8 = null,

    /// The Amazon SNS topics where you want the inference response to be included.
    ///
    /// The inference response is included only if the response size is less than or
    /// equal to 128 KB.
    include_inference_response_in: ?[]const AsyncNotificationTopicTypes = null,

    /// Amazon SNS topic to post a notification to when inference completes
    /// successfully. If no topic is provided, no notification is sent on success.
    success_topic: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_topic = "ErrorTopic",
        .include_inference_response_in = "IncludeInferenceResponseIn",
        .success_topic = "SuccessTopic",
    };
};
