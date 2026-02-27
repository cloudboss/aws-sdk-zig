const EvaluationReviewNotificationRecipient = @import("evaluation_review_notification_recipient.zig").EvaluationReviewNotificationRecipient;

/// Configuration settings for evaluation reviews.
pub const EvaluationReviewConfiguration = struct {
    /// Number of days during which a request for review can be submitted for
    /// evaluations created from this form.
    eligibility_days: i32 = 0,

    /// List of recipients who should be notified when a review is requested.
    review_notification_recipients: []const EvaluationReviewNotificationRecipient,

    pub const json_field_names = .{
        .eligibility_days = "EligibilityDays",
        .review_notification_recipients = "ReviewNotificationRecipients",
    };
};
