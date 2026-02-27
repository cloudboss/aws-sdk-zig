const MessageUsefulnessReason = @import("message_usefulness_reason.zig").MessageUsefulnessReason;
const MessageUsefulness = @import("message_usefulness.zig").MessageUsefulness;

/// End user feedback on an AI-generated web experience chat message usefulness.
pub const MessageUsefulnessFeedback = struct {
    /// A comment given by an end user on the usefulness of an AI-generated chat
    /// message.
    comment: ?[]const u8,

    /// The reason for a usefulness rating.
    reason: ?MessageUsefulnessReason,

    /// The timestamp for when the feedback was submitted.
    submitted_at: i64,

    /// The usefulness value assigned by an end user to a message.
    usefulness: MessageUsefulness,

    pub const json_field_names = .{
        .comment = "comment",
        .reason = "reason",
        .submitted_at = "submittedAt",
        .usefulness = "usefulness",
    };
};
