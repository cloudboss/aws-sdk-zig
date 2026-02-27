const RedshiftQueryEngineConfiguration = @import("redshift_query_engine_configuration.zig").RedshiftQueryEngineConfiguration;
const QueryGenerationConfiguration = @import("query_generation_configuration.zig").QueryGenerationConfiguration;
const RedshiftQueryEngineStorageConfiguration = @import("redshift_query_engine_storage_configuration.zig").RedshiftQueryEngineStorageConfiguration;

/// Contains configurations for an Amazon Redshift database. For more
/// information, see [Build a knowledge base by connecting to a structured data
/// source](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-build-structured.html) in the Amazon Bedrock User Guide.
pub const RedshiftConfiguration = struct {
    /// Specifies configurations for an Amazon Redshift query engine.
    query_engine_configuration: RedshiftQueryEngineConfiguration,

    /// Specifies configurations for generating queries.
    query_generation_configuration: ?QueryGenerationConfiguration,

    /// Specifies configurations for Amazon Redshift database storage.
    storage_configurations: []const RedshiftQueryEngineStorageConfiguration,

    pub const json_field_names = .{
        .query_engine_configuration = "queryEngineConfiguration",
        .query_generation_configuration = "queryGenerationConfiguration",
        .storage_configurations = "storageConfigurations",
    };
};
