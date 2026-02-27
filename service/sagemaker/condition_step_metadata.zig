const ConditionOutcome = @import("condition_outcome.zig").ConditionOutcome;

/// Metadata for a Condition step.
pub const ConditionStepMetadata = struct {
    /// The outcome of the Condition step evaluation.
    outcome: ?ConditionOutcome,

    pub const json_field_names = .{
        .outcome = "Outcome",
    };
};
