const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return email addresses.
pub const EmailAddressSearchCriteria = struct {
    /// A list of conditions which would be applied together with an AND condition.
    and_conditions: ?[]const EmailAddressSearchCriteria,

    /// A list of conditions which would be applied together with an OR condition.
    or_conditions: ?[]const EmailAddressSearchCriteria,

    string_condition: ?StringCondition,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
