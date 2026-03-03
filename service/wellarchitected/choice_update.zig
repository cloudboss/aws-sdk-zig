const ChoiceReason = @import("choice_reason.zig").ChoiceReason;
const ChoiceStatus = @import("choice_status.zig").ChoiceStatus;

/// A list of choices to be updated.
pub const ChoiceUpdate = struct {
    /// The notes associated with a choice.
    notes: ?[]const u8 = null,

    /// The reason why a choice is non-applicable to a question in your workload.
    reason: ?ChoiceReason = null,

    /// The status of a choice.
    status: ChoiceStatus,

    pub const json_field_names = .{
        .notes = "Notes",
        .reason = "Reason",
        .status = "Status",
    };
};
