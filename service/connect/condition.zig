const NumberCondition = @import("number_condition.zig").NumberCondition;
const StringCondition = @import("string_condition.zig").StringCondition;

/// A leaf node condition which can be used to specify a ProficiencyName,
/// ProficiencyValue and
/// ProficiencyLimit.
pub const Condition = struct {
    /// A leaf node condition which can be used to specify a numeric condition.
    number_condition: ?NumberCondition,

    /// A leaf node condition which can be used to specify a string condition.
    ///
    /// The currently supported values for `FieldName` are `name` and `value`.
    string_condition: ?StringCondition,

    pub const json_field_names = .{
        .number_condition = "NumberCondition",
        .string_condition = "StringCondition",
    };
};
