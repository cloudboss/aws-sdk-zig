const FeedbackValueType = @import("feedback_value_type.zig").FeedbackValueType;

/// The feedback that your application submitted to a threat protection event
/// log, as
/// displayed in an `AdminListUserAuthEvents` response.
pub const EventFeedbackType = struct {
    /// The date that you or your user submitted the feedback.
    feedback_date: ?i64 = null,

    /// Your feedback to the authentication event. When you provide a
    /// `FeedbackValue`
    /// value of `valid`, you tell Amazon Cognito that you trust a user session
    /// where Amazon Cognito
    /// has evaluated some level of risk. When you provide a `FeedbackValue` value
    /// of
    /// `invalid`, you tell Amazon Cognito that you don't trust a user session, or
    /// you
    /// don't believe that Amazon Cognito evaluated a high-enough risk level.
    feedback_value: FeedbackValueType,

    /// The submitter of the event feedback. For example, if you submit event
    /// feedback in the
    /// Amazon Cognito console, this value is `Admin`.
    provider: []const u8,

    pub const json_field_names = .{
        .feedback_date = "FeedbackDate",
        .feedback_value = "FeedbackValue",
        .provider = "Provider",
    };
};
