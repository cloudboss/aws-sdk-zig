const ApiSchemaConfiguration = @import("api_schema_configuration.zig").ApiSchemaConfiguration;

/// The API schema configuration for an HTTP target. This schema defines the API
/// structure that the target exposes.
pub const HttpApiSchemaConfiguration = struct {
    source: ApiSchemaConfiguration,

    pub const json_field_names = .{
        .source = "source",
    };
};
