const DocumentParameterType = @import("document_parameter_type.zig").DocumentParameterType;

/// Parameters specified in a Systems Manager document that run on the server
/// when the command is run.
pub const DocumentParameter = struct {
    /// If specified, the default values for the parameters. Parameters without a
    /// default value are
    /// required. Parameters with a default value are optional.
    default_value: ?[]const u8 = null,

    /// A description of what the parameter does, how to use it, the default value,
    /// and whether or
    /// not the parameter is optional.
    description: ?[]const u8 = null,

    /// The name of the parameter.
    name: ?[]const u8 = null,

    /// The type of parameter. The type can be either String or StringList.
    @"type": ?DocumentParameterType = null,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .description = "Description",
        .name = "Name",
        .@"type" = "Type",
    };
};
