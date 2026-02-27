/// A record created when a user submits a form card.
pub const Submission = struct {
    /// The unique identifier of the submission.
    submission_id: ?[]const u8,

    /// The date and time when the card is submitted.
    timestamp: ?i64,

    /// The data submitted by the user.
    value: ?[]const u8,

    pub const json_field_names = .{
        .submission_id = "submissionId",
        .timestamp = "timestamp",
        .value = "value",
    };
};
