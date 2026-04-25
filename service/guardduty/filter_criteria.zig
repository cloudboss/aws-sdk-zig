const FilterCriterion = @import("filter_criterion.zig").FilterCriterion;

/// Represents the criteria to be used in the filter for describing scan
/// entries.
pub const FilterCriteria = struct {
    /// Represents a condition that when matched will be added to the response of
    /// the operation.
    filter_criterion: ?[]const FilterCriterion = null,

    pub const json_field_names = .{
        .filter_criterion = "FilterCriterion",
    };
};
