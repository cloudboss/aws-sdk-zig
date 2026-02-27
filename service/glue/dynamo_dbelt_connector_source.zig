const DDBELTConnectionOptions = @import("ddbelt_connection_options.zig").DDBELTConnectionOptions;
const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a DynamoDB ELT connector source for extracting data from DynamoDB
/// tables.
pub const DynamoDBELTConnectorSource = struct {
    /// The connection options for the DynamoDB ELT connector source.
    connection_options: ?DDBELTConnectionOptions,

    /// The name of the DynamoDB ELT connector source.
    name: []const u8,

    /// Specifies the data schema for the DynamoDB ELT connector source.
    output_schemas: ?[]const GlueSchema,

    pub const json_field_names = .{
        .connection_options = "ConnectionOptions",
        .name = "Name",
        .output_schemas = "OutputSchemas",
    };
};
