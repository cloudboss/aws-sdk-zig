/// The options for customizing a security control parameter that is a list of
/// strings.
pub const StringListConfigurationOptions = struct {
    /// The Security Hub default value for a control parameter that is a list of
    /// strings.
    default_value: ?[]const []const u8,

    /// The description of the RE2 regular expression.
    expression_description: ?[]const u8,

    /// The maximum number of list items that a string list control parameter can
    /// accept.
    max_items: ?i32,

    /// An RE2 regular expression that Security Hub uses to validate a user-provided
    /// list of strings for a control
    /// parameter.
    re_2_expression: ?[]const u8,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .expression_description = "ExpressionDescription",
        .max_items = "MaxItems",
        .re_2_expression = "Re2Expression",
    };
};
