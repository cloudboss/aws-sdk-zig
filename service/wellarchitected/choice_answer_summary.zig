const ChoiceReason = @import("choice_reason.zig").ChoiceReason;
const ChoiceStatus = @import("choice_status.zig").ChoiceStatus;

/// A choice summary that has been answered on a question in your workload.
pub const ChoiceAnswerSummary = struct {
    choice_id: ?[]const u8 = null,

    /// The reason why a choice is non-applicable to a question in your workload.
    reason: ?ChoiceReason = null,

    /// The status of a choice.
    status: ?ChoiceStatus = null,

    pub const json_field_names = .{
        .choice_id = "ChoiceId",
        .reason = "Reason",
        .status = "Status",
    };
};
