const PreEvaluationFilter = @import("pre_evaluation_filter.zig").PreEvaluationFilter;

/// The pre-evaluation filters for a rule, that restrict a rule to be applied to
/// only certain resources based on
/// the resource's attributes, such as tags assigned to a contact. The
/// pre-evaluation filters are applied even before
/// rule conditions are evaluated and are used to enforce
/// tag-based-access-control while applying rules.
pub const PreEvaluationFilters = struct {
    /// A list of conditions that the rule evaluates together using AND logic. All
    /// conditions must be met for
    /// the event to be evaluated by the rule.
    and_conditions: ?[]const PreEvaluationFilter = null,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
    };
};
