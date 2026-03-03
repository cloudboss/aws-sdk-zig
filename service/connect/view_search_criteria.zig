const StringCondition = @import("string_condition.zig").StringCondition;
const ViewStatus = @import("view_status.zig").ViewStatus;
const ViewType = @import("view_type.zig").ViewType;

/// Defines the search criteria for filtering views.
pub const ViewSearchCriteria = struct {
    /// A list of conditions that must all be satisfied.
    and_conditions: ?[]const ViewSearchCriteria = null,

    /// A list of conditions to be met, where at least one condition must be
    /// satisfied.
    or_conditions: ?[]const ViewSearchCriteria = null,

    string_condition: ?StringCondition = null,

    /// A condition that filters views by their status.
    view_status_condition: ?ViewStatus = null,

    /// A condition that filters views by their type.
    view_type_condition: ?ViewType = null,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
        .view_status_condition = "ViewStatusCondition",
        .view_type_condition = "ViewTypeCondition",
    };
};
