const ConditionalBranch = @import("conditional_branch.zig").ConditionalBranch;
const DefaultConditionalBranch = @import("default_conditional_branch.zig").DefaultConditionalBranch;

/// Provides a list of conditional branches. Branches are evaluated in
/// the order that they are entered in the list. The first branch with a
/// condition that evaluates to true is executed. The last branch in the
/// list is the default branch. The default branch should not have any condition
/// expression. The default branch is executed if no other branch has a
/// matching condition.
pub const ConditionalSpecification = struct {
    /// Determines whether a conditional branch is active. When
    /// `active` is false, the conditions are not
    /// evaluated.
    active: bool,

    /// A list of conditional branches. A conditional branch is made up of a
    /// condition, a response and a next step. The response and next step are
    /// executed when the condition is true.
    conditional_branches: []const ConditionalBranch,

    /// The conditional branch that should be followed when the conditions
    /// for other branches are not satisfied. A conditional branch is made up
    /// of a condition, a response and a next step.
    default_branch: DefaultConditionalBranch,

    pub const json_field_names = .{
        .active = "active",
        .conditional_branches = "conditionalBranches",
        .default_branch = "defaultBranch",
    };
};
