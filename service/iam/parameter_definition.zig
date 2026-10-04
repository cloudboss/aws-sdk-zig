const parameterTypeType = @import("parameter_type_type.zig").parameterTypeType;

/// Defines a parameter that a role template accepts. You supply values for
/// these parameters
/// when you create a role with
/// [AcquireRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_AcquireRole.html).
pub const ParameterDefinition = struct {
    /// The value that the service uses for the parameter when you do not supply
    /// one.
    default_value: ?[]const u8 = null,

    /// A description of the parameter.
    description: ?[]const u8 = null,

    /// Specifies whether you can change the parameter value after you create the
    /// role.
    immutable: bool = false,

    /// Specifies whether you must supply a value for the parameter when you create
    /// a role from
    /// the template.
    is_required: bool = false,

    /// The name of the parameter.
    name: []const u8,

    /// An optional subtype that further constrains the values that are allowed for
    /// the
    /// parameter.
    sub_type: ?[]const u8 = null,

    /// The data type of the parameter. Valid values are `String`,
    /// `StringList`, `Number`, `NumberList`,
    /// `Arn`, and `ArnList`.
    @"type": parameterTypeType,
};
