/// Parameters supported by the application.
pub const ParameterDefinition = struct {
    /// A regular expression that represents the patterns to allow for String types.
    allowed_pattern: ?[]const u8 = null,

    /// An array containing the list of values allowed for the parameter.
    allowed_values: ?[]const []const u8 = null,

    /// A string that explains a constraint when the constraint is violated. For
    /// example, without a constraint description,
    /// a parameter that has an allowed pattern of [A-Za-z0-9]+ displays the
    /// following error message when the user
    /// specifies an invalid value:
    ///
    /// Malformed input-Parameter MyParameter must match pattern [A-Za-z0-9]+
    ///
    /// By adding a constraint description, such as "must contain only uppercase and
    /// lowercase letters and numbers," you can display
    /// the following customized error message:
    ///
    /// Malformed input-Parameter MyParameter must contain only uppercase and
    /// lowercase letters and numbers.
    constraint_description: ?[]const u8 = null,

    /// A value of the appropriate type for the template to use if no value is
    /// specified when a stack is created.
    /// If you define constraints for the parameter, you must specify a value that
    /// adheres to those constraints.
    default_value: ?[]const u8 = null,

    /// A string of up to 4,000 characters that describes the parameter.
    description: ?[]const u8 = null,

    /// An integer value that determines the largest number of characters that you
    /// want to allow for String types.
    max_length: ?i32 = null,

    /// A numeric value that determines the largest numeric value that you want to
    /// allow for Number types.
    max_value: ?i32 = null,

    /// An integer value that determines the smallest number of characters that you
    /// want to allow for String types.
    min_length: ?i32 = null,

    /// A numeric value that determines the smallest numeric value that you want to
    /// allow for Number types.
    min_value: ?i32 = null,

    /// The name of the parameter.
    name: []const u8,

    /// Whether to mask the parameter value whenever anyone makes a call that
    /// describes the stack. If you set the
    /// value to true, the parameter value is masked with asterisks (*****).
    no_echo: ?bool = null,

    /// A list of AWS SAM resources that use this parameter.
    referenced_by_resources: []const []const u8,

    /// The type of the parameter.
    ///
    /// Valid values: String | Number | List<Number> | CommaDelimitedList
    ///
    /// String: A literal string.
    ///
    /// For example, users can specify "MyUserName".
    ///
    /// Number: An integer or float. AWS CloudFormation validates the parameter
    /// value as a number. However, when you use the
    /// parameter elsewhere in your template (for example, by using the Ref
    /// intrinsic function), the parameter value becomes a string.
    ///
    /// For example, users might specify "8888".
    ///
    /// List<Number>: An array of integers or floats that are separated by commas.
    /// AWS CloudFormation validates the parameter value as numbers. However, when
    /// you use the parameter elsewhere in your template (for example, by using the
    /// Ref intrinsic function), the parameter value becomes a list of strings.
    ///
    /// For example, users might specify "80,20", and then Ref results in
    /// ["80","20"].
    ///
    /// CommaDelimitedList: An array of literal strings that are separated by
    /// commas. The total number of strings should be one more than the total number
    /// of commas.
    /// Also, each member string is space-trimmed.
    ///
    /// For example, users might specify "test,dev,prod", and then Ref results in
    /// ["test","dev","prod"].
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_pattern = "AllowedPattern",
        .allowed_values = "AllowedValues",
        .constraint_description = "ConstraintDescription",
        .default_value = "DefaultValue",
        .description = "Description",
        .max_length = "MaxLength",
        .max_value = "MaxValue",
        .min_length = "MinLength",
        .min_value = "MinValue",
        .name = "Name",
        .no_echo = "NoEcho",
        .referenced_by_resources = "ReferencedByResources",
        .@"type" = "Type",
    };
};
