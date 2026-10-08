const EvaluationReviewNotificationRecipientType = @import("evaluation_review_notification_recipient_type.zig").EvaluationReviewNotificationRecipientType;
const EvaluationReviewNotificationRecipientValue = @import("evaluation_review_notification_recipient_value.zig").EvaluationReviewNotificationRecipientValue;

/// Information about a recipient who should be notified when an evaluation
/// review is requested.
pub const EvaluationReviewNotificationRecipient = struct {
    /// The type of notification recipient.
    type: EvaluationReviewNotificationRecipientType,

    /// The value associated with the notification recipient type.
    value: EvaluationReviewNotificationRecipientValue,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
