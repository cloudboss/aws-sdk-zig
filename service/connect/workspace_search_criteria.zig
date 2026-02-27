const StringCondition = @import("string_condition.zig").StringCondition;

/// Defines the search criteria for filtering workspaces.
pub const WorkspaceSearchCriteria = struct {
    /// A list of conditions that must all be satisfied.
    and_conditions: ?[]const WorkspaceSearchCriteria,

    /// A list of conditions to be met, where at least one condition must be
    /// satisfied.
    or_conditions: ?[]const WorkspaceSearchCriteria,

    string_condition: ?StringCondition,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
