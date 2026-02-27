const APISchema = @import("api_schema.zig").APISchema;
const APISchemaType = @import("api_schema_type.zig").APISchemaType;

/// Configuration information required to create a custom plugin.
pub const CustomPluginConfiguration = struct {
    /// Contains either details about the S3 object containing the OpenAPI schema
    /// for the action group or the JSON or YAML-formatted payload defining the
    /// schema.
    api_schema: ?APISchema,

    /// The type of OpenAPI schema to use.
    api_schema_type: APISchemaType,

    /// A description for your custom plugin configuration.
    description: []const u8,

    pub const json_field_names = .{
        .api_schema = "apiSchema",
        .api_schema_type = "apiSchemaType",
        .description = "description",
    };
};
