const ConditionParameter = @import("condition_parameter.zig").ConditionParameter;

/// Contains information about which resources to include or exclude from a
/// backup plan
/// using their tags. Conditions are case sensitive.
pub const Conditions = struct {
    /// Filters the values of your tagged resources for only those resources that
    /// you tagged
    /// with the same value. Also called "exact matching."
    string_equals: ?[]const ConditionParameter = null,

    /// Filters the values of your tagged resources for matching tag values with the
    /// use of a
    /// wildcard character (*) anywhere in the string. For example, "prod*" or
    /// "*rod*" matches the
    /// tag value "production".
    string_like: ?[]const ConditionParameter = null,

    /// Filters the values of your tagged resources for only those resources that
    /// you tagged
    /// that do not have the same value. Also called "negated matching."
    string_not_equals: ?[]const ConditionParameter = null,

    /// Filters the values of your tagged resources for non-matching tag values with
    /// the use of
    /// a wildcard character (*) anywhere in the string.
    string_not_like: ?[]const ConditionParameter = null,

    pub const json_field_names = .{
        .string_equals = "StringEquals",
        .string_like = "StringLike",
        .string_not_equals = "StringNotEquals",
        .string_not_like = "StringNotLike",
    };
};
