/// The options for customizing a security control parameter that is a string.
pub const StringConfigurationOptions = struct {
    /// The Security Hub default value for a control parameter that is a string.
    default_value: ?[]const u8 = null,

    /// The description of the RE2 regular expression.
    expression_description: ?[]const u8 = null,

    /// An RE2 regular expression that Security Hub uses to validate a user-provided
    /// control parameter string.
    re_2_expression: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .expression_description = "ExpressionDescription",
        .re_2_expression = "Re2Expression",
    };
};
