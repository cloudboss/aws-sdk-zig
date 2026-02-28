const RedshiftConfiguration = @import("redshift_configuration.zig").RedshiftConfiguration;
const QueryEngineType = @import("query_engine_type.zig").QueryEngineType;

/// Contains configurations for a knowledge base connected to an SQL database.
/// Specify the SQL database type in the `type` field and include the
/// corresponding field. For more information, see [Build a knowledge base by
/// connecting to a structured data
/// source](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-build-structured.html) in the Amazon Bedrock User Guide.
pub const SqlKnowledgeBaseConfiguration = struct {
    /// Specifies configurations for a knowledge base connected to an Amazon
    /// Redshift database.
    redshift_configuration: ?RedshiftConfiguration,

    /// The type of SQL database to connect to the knowledge base.
    @"type": QueryEngineType,

    pub const json_field_names = .{
        .redshift_configuration = "redshiftConfiguration",
        .@"type" = "type",
    };
};
