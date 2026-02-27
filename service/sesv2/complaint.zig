/// Information about a `Complaint` event.
pub const Complaint = struct {
    /// The value of the `Feedback-Type` field from the feedback report received
    /// from the ISP.
    complaint_feedback_type: ?[]const u8,

    /// Can either be `null` or `OnAccountSuppressionList`.
    /// If the value is `OnAccountSuppressionList`, SES accepted the message,
    /// but didn't attempt to send it because it was on the account-level
    /// suppression list.
    complaint_sub_type: ?[]const u8,

    pub const json_field_names = .{
        .complaint_feedback_type = "ComplaintFeedbackType",
        .complaint_sub_type = "ComplaintSubType",
    };
};
