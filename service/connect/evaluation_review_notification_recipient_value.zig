/// The value information for an evaluation review notification recipient.
pub const EvaluationReviewNotificationRecipientValue = struct {
    /// The user identifier for the notification recipient.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .user_id = "UserId",
    };
};
