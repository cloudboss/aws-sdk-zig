const FilterBehavior = @import("filter_behavior.zig").FilterBehavior;
const Condition = @import("condition.zig").Condition;
const FilterRequirement = @import("filter_requirement.zig").FilterRequirement;

/// A single logging filter, used in LoggingFilter.
pub const Filter = struct {
    /// How to handle logs that satisfy the filter's conditions and requirement.
    behavior: FilterBehavior,

    /// Match conditions for the filter.
    conditions: []const Condition,

    /// Logic to apply to the filtering conditions. You can specify that, in order
    /// to satisfy
    /// the filter, a log must match all conditions or must match at least one
    /// condition.
    requirement: FilterRequirement,

    pub const json_field_names = .{
        .behavior = "Behavior",
        .conditions = "Conditions",
        .requirement = "Requirement",
    };
};
