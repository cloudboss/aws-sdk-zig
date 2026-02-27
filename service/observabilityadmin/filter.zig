const FilterBehavior = @import("filter_behavior.zig").FilterBehavior;
const Condition = @import("condition.zig").Condition;
const FilterRequirement = @import("filter_requirement.zig").FilterRequirement;

/// A single filter condition that specifies behavior, requirement, and matching
/// conditions for WAF log records.
pub const Filter = struct {
    /// The action to take for log records matching this filter (KEEP or DROP).
    behavior: ?FilterBehavior,

    /// The list of conditions that determine if a log record matches this filter.
    conditions: ?[]const Condition,

    /// Whether the log record must meet all conditions (MEETS_ALL) or any condition
    /// (MEETS_ANY) to match this filter.
    requirement: ?FilterRequirement,

    pub const json_field_names = .{
        .behavior = "Behavior",
        .conditions = "Conditions",
        .requirement = "Requirement",
    };
};
