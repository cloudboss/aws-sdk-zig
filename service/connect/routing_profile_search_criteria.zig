const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return routing profiles.
///
/// The `name` and `description` fields support "contains" queries with
/// a minimum of 2 characters and a maximum of 25 characters. Any queries with
/// character lengths
/// outside of this range will throw invalid results.
pub const RoutingProfileSearchCriteria = struct {
    /// A list of conditions which would be applied together with an AND condition.
    and_conditions: ?[]const RoutingProfileSearchCriteria,

    /// A list of conditions which would be applied together with an OR condition.
    or_conditions: ?[]const RoutingProfileSearchCriteria,

    /// A leaf node condition which can be used to specify a string condition.
    ///
    /// The currently supported values for `FieldName` are `associatedQueueIds`,
    /// `name`, `description`, and `resourceID`.
    string_condition: ?StringCondition,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
