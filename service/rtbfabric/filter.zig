const FilterCriterion = @import("filter_criterion.zig").FilterCriterion;

/// Describes the configuration of a filter.
pub const Filter = struct {
    /// Describes the criteria for a filter.
    criteria: []const FilterCriterion,

    pub const json_field_names = .{
        .criteria = "criteria",
    };
};
