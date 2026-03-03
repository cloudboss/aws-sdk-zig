const User = @import("user.zig").User;

/// The response collected for a Amazon Q App session. This container represents
/// a single response to a Q App session.
pub const QAppSessionData = struct {
    /// The card Id associated with the response submitted for a Q App session.
    card_id: []const u8,

    /// The unique identifier of the submission.
    submission_id: ?[]const u8 = null,

    /// The date and time when the session data is submitted.
    timestamp: ?i64 = null,

    /// The user who submitted the response for a Q App session.
    user: User,

    /// The response submitted for a Q App session.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .card_id = "cardId",
        .submission_id = "submissionId",
        .timestamp = "timestamp",
        .user = "user",
        .value = "value",
    };
};
