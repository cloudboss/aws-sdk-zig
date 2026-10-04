const FeedbackCode = @import("feedback_code.zig").FeedbackCode;

/// Describes a condition that was detected in the Face Liveness video and that
/// contributed to
/// the confidence score returned for the session.
pub const FeedbackItem = struct {
    /// A code identifying the condition that was detected during the Face Liveness
    /// session.
    code: FeedbackCode,

    /// A human-readable description of the detected condition, suitable for
    /// displaying to an end
    /// user before they retry a Face Liveness check. Use `Code` rather than this
    /// message
    /// for programmatic decisions, because the message text can change.
    message: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
