const ParameterType = @import("parameter_type.zig").ParameterType;

/// Describes a parameter accepted by a test template.
pub const TestTemplateParameter = struct {
    /// The default value of the parameter.
    default_value: ?[]const u8 = null,

    /// A description of the parameter.
    description: ?[]const u8 = null,

    /// The maximum number of values the parameter accepts.
    max_values: ?i32 = null,

    /// The name of the parameter.
    name: []const u8,

    /// Indicates whether the parameter is required.
    required: bool,

    /// The data type of the parameter.
    type: ParameterType,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .description = "description",
        .max_values = "maxValues",
        .name = "name",
        .required = "required",
        .type = "type",
    };
};
