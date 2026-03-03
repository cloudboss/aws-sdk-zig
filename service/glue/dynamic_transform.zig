const GlueSchema = @import("glue_schema.zig").GlueSchema;
const TransformConfigParameter = @import("transform_config_parameter.zig").TransformConfigParameter;

/// Specifies the set of parameters needed to perform the dynamic transform.
pub const DynamicTransform = struct {
    /// Specifies the name of the function of the dynamic transform.
    function_name: []const u8,

    /// Specifies the inputs for the dynamic transform that are required.
    inputs: []const []const u8,

    /// Specifies the name of the dynamic transform.
    name: []const u8,

    /// Specifies the data schema for the dynamic transform.
    output_schemas: ?[]const GlueSchema = null,

    /// Specifies the parameters of the dynamic transform.
    parameters: ?[]const TransformConfigParameter = null,

    /// Specifies the path of the dynamic transform source and config files.
    path: []const u8,

    /// Specifies the name of the dynamic transform as it appears in the Glue Studio
    /// visual editor.
    transform_name: []const u8,

    /// This field is not used and will be deprecated in future release.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .function_name = "FunctionName",
        .inputs = "Inputs",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .parameters = "Parameters",
        .path = "Path",
        .transform_name = "TransformName",
        .version = "Version",
    };
};
