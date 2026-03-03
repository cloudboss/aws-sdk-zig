const CriterionKey = @import("criterion_key.zig").CriterionKey;
const FilterCondition = @import("filter_condition.zig").FilterCondition;

/// Represents a condition that when matched will be added to the response of
/// the operation.
/// Irrespective of using any filter criteria, an administrator account can view
/// the scan entries
/// for all of its member accounts. However, each member account can view the
/// scan entries only
/// for their own account.
pub const FilterCriterion = struct {
    /// An enum value representing possible scan properties to match with given scan
    /// entries.
    criterion_key: ?CriterionKey = null,

    /// Contains information about the condition.
    filter_condition: ?FilterCondition = null,

    pub const json_field_names = .{
        .criterion_key = "CriterionKey",
        .filter_condition = "FilterCondition",
    };
};
