const CoverageFilterCriterion = @import("coverage_filter_criterion.zig").CoverageFilterCriterion;

/// Represents the criteria used in the filter.
pub const CoverageFilterCriteria = struct {
    /// Represents a condition that when matched will be added to the response of
    /// the
    /// operation.
    filter_criterion: ?[]const CoverageFilterCriterion,

    pub const json_field_names = .{
        .filter_criterion = "FilterCriterion",
    };
};
