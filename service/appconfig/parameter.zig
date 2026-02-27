/// A value such as an Amazon Resource Name (ARN) or an Amazon Simple
/// Notification Service topic entered
/// in an extension when invoked. Parameter values are specified in an extension
/// association.
/// For more information about extensions, see [Extending
/// workflows](https://docs.aws.amazon.com/appconfig/latest/userguide/working-with-appconfig-extensions.html) in the *AppConfig User Guide*.
pub const Parameter = struct {
    /// Information about the parameter.
    description: ?[]const u8,

    /// Indicates whether this parameter's value can be supplied at the extension's
    /// action point
    /// instead of during extension association. Dynamic parameters can't be marked
    /// `Required`.
    dynamic: bool = false,

    /// A parameter value must be specified in the extension association.
    required: bool = false,

    pub const json_field_names = .{
        .description = "Description",
        .dynamic = "Dynamic",
        .required = "Required",
    };
};
