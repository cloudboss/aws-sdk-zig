const HierarchyGroupCondition = @import("hierarchy_group_condition.zig").HierarchyGroupCondition;
const ListCondition = @import("list_condition.zig").ListCondition;
const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return users.
///
/// The `name` and `description` fields support "contains" queries with
/// a minimum of 2 characters and a maximum of 25 characters. Any queries with
/// character lengths
/// outside of this range will throw invalid results.
pub const UserSearchCriteria = struct {
    /// A list of conditions which would be applied together with an `AND`
    /// condition.
    and_conditions: ?[]const UserSearchCriteria,

    /// A leaf node condition which can be used to specify a hierarchy group
    /// condition.
    hierarchy_group_condition: ?HierarchyGroupCondition,

    /// A leaf node condition which can be used to specify a List condition to
    /// search users with attributes included in
    /// Lists like Proficiencies.
    list_condition: ?ListCondition,

    /// A list of conditions which would be applied together with an `OR` condition.
    or_conditions: ?[]const UserSearchCriteria,

    /// A leaf node condition which can be used to specify a string condition.
    ///
    /// The currently supported values for `FieldName` are `Username`, `FirstName`,
    /// `LastName`, `RoutingProfileId`, `SecurityProfileId`,
    /// `resourceId`.
    string_condition: ?StringCondition,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .hierarchy_group_condition = "HierarchyGroupCondition",
        .list_condition = "ListCondition",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
