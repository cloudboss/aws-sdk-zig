const SubmissionMutation = @import("submission_mutation.zig").SubmissionMutation;

/// The value or result associated with a card in a Amazon Q App session.
pub const CardValue = struct {
    /// The unique identifier of the card.
    card_id: []const u8,

    /// The structure that describes how the current form card value is mutated.
    /// Only applies for form cards when multiple responses are allowed.
    submission_mutation: ?SubmissionMutation = null,

    /// The value or result associated with the card.
    value: []const u8,

    pub const json_field_names = .{
        .card_id = "cardId",
        .submission_mutation = "submissionMutation",
        .value = "value",
    };
};
