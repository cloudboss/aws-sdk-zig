const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return quick connects.
pub const QuickConnectSearchCriteria = struct {
    /// A list of conditions which would be applied together with an AND condition.
    and_conditions: ?[]const QuickConnectSearchCriteria,

    /// A list of conditions which would be applied together with an OR condition.
    or_conditions: ?[]const QuickConnectSearchCriteria,

    /// A leaf node condition which can be used to specify a string condition.
    ///
    /// The currently supported values for `FieldName` are `name`, `description`,
    /// and
    /// `resourceID`.
    string_condition: ?StringCondition,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
