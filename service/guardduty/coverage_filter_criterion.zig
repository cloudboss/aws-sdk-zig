const CoverageFilterCriterionKey = @import("coverage_filter_criterion_key.zig").CoverageFilterCriterionKey;
const CoverageFilterCondition = @import("coverage_filter_condition.zig").CoverageFilterCondition;

/// Represents a condition that when matched will be added to the response of
/// the
/// operation.
pub const CoverageFilterCriterion = struct {
    /// An enum value representing possible filter fields.
    ///
    /// Replace the enum value `CLUSTER_NAME` with `EKS_CLUSTER_NAME`.
    /// `CLUSTER_NAME` has been deprecated.
    criterion_key: ?CoverageFilterCriterionKey = null,

    /// Contains information about the condition.
    filter_condition: ?CoverageFilterCondition = null,

    pub const json_field_names = .{
        .criterion_key = "CriterionKey",
        .filter_condition = "FilterCondition",
    };
};
