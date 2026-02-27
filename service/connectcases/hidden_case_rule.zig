const BooleanCondition = @import("boolean_condition.zig").BooleanCondition;

/// A rule that controls field visibility based on conditions. Fields can be
/// shown or hidden dynamically based on values in other fields.
pub const HiddenCaseRule = struct {
    /// A list of conditions that determine field visibility.
    conditions: []const BooleanCondition,

    /// Whether the field is hidden when no conditions match.
    default_value: bool,

    pub const json_field_names = .{
        .conditions = "conditions",
        .default_value = "defaultValue",
    };
};
