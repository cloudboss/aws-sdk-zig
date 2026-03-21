const ActionFailurePolicy = @import("action_failure_policy.zig").ActionFailurePolicy;
const SnsNotificationEncoding = @import("sns_notification_encoding.zig").SnsNotificationEncoding;
const SnsNotificationPayloadType = @import("sns_notification_payload_type.zig").SnsNotificationPayloadType;

/// The action to publish the email content to an Amazon SNS topic. When
/// executed, this action will send the email as a notification to the specified
/// SNS topic.
pub const SnsAction = struct {
    /// A policy that states what to do in the case of failure. The action will fail
    /// if there are configuration errors. For example, specified SNS topic has been
    /// deleted or the role lacks necessary permissions to call the `sns:Publish`
    /// API.
    action_failure_policy: ?ActionFailurePolicy = null,

    /// The encoding to use for the email within the Amazon SNS notification. The
    /// default value is `UTF-8`. Use `BASE64` if you need to preserve all special
    /// characters, especially when the original message uses a different encoding
    /// format.
    encoding: SnsNotificationEncoding = .utf_8,

    /// The expected payload type within the Amazon SNS notification. `CONTENT`
    /// attempts to publish the full email content with 20KB of headers content.
    /// `HEADERS` extracts up to 100KB of header content to include in the
    /// notification, email content will not be included to the notification. The
    /// default value is `CONTENT`.
    payload_type: SnsNotificationPayloadType = .content,

    /// The Amazon Resource Name (ARN) of the IAM Role to use while writing to
    /// Amazon SNS. This role must have access to the `sns:Publish` API for the
    /// given topic.
    role_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon SNS Topic to which notification
    /// for the email received will be published.
    topic_arn: []const u8,

    pub const json_field_names = .{
        .action_failure_policy = "ActionFailurePolicy",
        .encoding = "Encoding",
        .payload_type = "PayloadType",
        .role_arn = "RoleArn",
        .topic_arn = "TopicArn",
    };
};
