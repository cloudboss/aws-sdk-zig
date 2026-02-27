const ParameterDefinitionSchema = @import("parameter_definition_schema.zig").ParameterDefinitionSchema;

/// A list of parameter values to add to the resource. A parameter is specified
/// as a key-value pair. A valid parameter value must exist for any parameter
/// that is marked as required in the multi-tenant distribution.
pub const ParameterDefinition = struct {
    /// The value that you assigned to the parameter.
    definition: ParameterDefinitionSchema,

    /// The name of the parameter.
    name: []const u8,
};
