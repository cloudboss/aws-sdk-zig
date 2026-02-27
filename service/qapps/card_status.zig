const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const Submission = @import("submission.zig").Submission;

/// The current status and value of a card in an active Amazon Q App session.
pub const CardStatus = struct {
    /// The current state of the card.
    current_state: ExecutionStatus,

    /// The current value or result associated with the card.
    current_value: []const u8,

    /// A list of previous submissions, if the card is a form card.
    submissions: ?[]const Submission,

    pub const json_field_names = .{
        .current_state = "currentState",
        .current_value = "currentValue",
        .submissions = "submissions",
    };
};
