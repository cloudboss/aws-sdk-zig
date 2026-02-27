const AutomatedReasoningPolicyMutation = @import("automated_reasoning_policy_mutation.zig").AutomatedReasoningPolicyMutation;
const AutomatedReasoningPolicyPlanning = @import("automated_reasoning_policy_planning.zig").AutomatedReasoningPolicyPlanning;

/// Provides context about what type of operation was being performed during a
/// build step.
pub const AutomatedReasoningPolicyBuildStepContext = union(enum) {
    /// Indicates that this build step involved modifying the policy structure, such
    /// as adding or updating rules, variables, or types.
    mutation: ?AutomatedReasoningPolicyMutation,
    /// Indicates that this build step was part of the planning phase, where the
    /// system determines what operations to perform.
    planning: ?AutomatedReasoningPolicyPlanning,

    pub const json_field_names = .{
        .mutation = "mutation",
        .planning = "planning",
    };
};
