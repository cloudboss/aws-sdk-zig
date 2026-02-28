const RedshiftProvisionedConfiguration = @import("redshift_provisioned_configuration.zig").RedshiftProvisionedConfiguration;
const RedshiftServerlessConfiguration = @import("redshift_serverless_configuration.zig").RedshiftServerlessConfiguration;
const RedshiftQueryEngineType = @import("redshift_query_engine_type.zig").RedshiftQueryEngineType;

/// Contains configurations for an Amazon Redshift query engine. Specify the
/// type of query engine in `type` and include the corresponding field. For more
/// information, see [Build a knowledge base by connecting to a structured data
/// source](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-build-structured.html) in the Amazon Bedrock User Guide.
pub const RedshiftQueryEngineConfiguration = struct {
    /// Specifies configurations for a provisioned Amazon Redshift query engine.
    provisioned_configuration: ?RedshiftProvisionedConfiguration,

    /// Specifies configurations for a serverless Amazon Redshift query engine.
    serverless_configuration: ?RedshiftServerlessConfiguration,

    /// The type of query engine.
    type: RedshiftQueryEngineType,

    pub const json_field_names = .{
        .provisioned_configuration = "provisionedConfiguration",
        .serverless_configuration = "serverlessConfiguration",
        .type = "type",
    };
};
