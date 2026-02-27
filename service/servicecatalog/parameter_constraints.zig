/// The constraints that the administrator has put on the parameter.
pub const ParameterConstraints = struct {
    /// A regular expression that represents the patterns that allow for `String`
    /// types. The pattern must match the entire parameter value provided.
    allowed_pattern: ?[]const u8,

    /// The values that the administrator has allowed for the parameter.
    allowed_values: ?[]const []const u8,

    /// A string that explains a constraint when the constraint is violated. For
    /// example, without a constraint description, a parameter that has an allowed
    /// pattern of `[A-Za-z0-9]+` displays the following error message when the user
    /// specifies an invalid value:
    ///
    /// `Malformed input-Parameter MyParameter must match pattern [A-Za-z0-9]+`
    ///
    /// By adding a constraint description, such as must only contain letters
    /// (uppercase and lowercase) and numbers, you can display the following
    /// customized error message:
    ///
    /// `Malformed input-Parameter MyParameter must only contain uppercase and
    /// lowercase letters and numbers.`
    constraint_description: ?[]const u8,

    /// An integer value that determines the largest number of characters you want
    /// to allow for `String` types.
    max_length: ?[]const u8,

    /// A numeric value that determines the largest numeric value you want to allow
    /// for `Number` types.
    max_value: ?[]const u8,

    /// An integer value that determines the smallest number of characters you want
    /// to allow for `String` types.
    min_length: ?[]const u8,

    /// A numeric value that determines the smallest numeric value you want to allow
    /// for `Number` types.
    min_value: ?[]const u8,

    pub const json_field_names = .{
        .allowed_pattern = "AllowedPattern",
        .allowed_values = "AllowedValues",
        .constraint_description = "ConstraintDescription",
        .max_length = "MaxLength",
        .max_value = "MaxValue",
        .min_length = "MinLength",
        .min_value = "MinValue",
    };
};
