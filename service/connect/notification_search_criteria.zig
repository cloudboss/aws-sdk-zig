const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return notifications.
pub const NotificationSearchCriteria = struct {
    /// A list of conditions that must all be satisfied.
    and_conditions: ?[]const NotificationSearchCriteria = null,

    /// A list of conditions to be met, where at least one condition must be
    /// satisfied.
    or_conditions: ?[]const NotificationSearchCriteria = null,

    string_condition: ?StringCondition = null,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
