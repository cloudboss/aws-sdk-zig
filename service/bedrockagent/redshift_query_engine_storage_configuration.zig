const RedshiftQueryEngineAwsDataCatalogStorageConfiguration = @import("redshift_query_engine_aws_data_catalog_storage_configuration.zig").RedshiftQueryEngineAwsDataCatalogStorageConfiguration;
const RedshiftQueryEngineRedshiftStorageConfiguration = @import("redshift_query_engine_redshift_storage_configuration.zig").RedshiftQueryEngineRedshiftStorageConfiguration;
const RedshiftQueryEngineStorageType = @import("redshift_query_engine_storage_type.zig").RedshiftQueryEngineStorageType;

/// Contains configurations for Amazon Redshift data storage. Specify the data
/// storage service to use in the `type` field and include the corresponding
/// field. For more information, see [Build a knowledge base by connecting to a
/// structured data
/// source](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-build-structured.html) in the Amazon Bedrock User Guide.
pub const RedshiftQueryEngineStorageConfiguration = struct {
    /// Specifies configurations for storage in Glue Data Catalog.
    aws_data_catalog_configuration: ?RedshiftQueryEngineAwsDataCatalogStorageConfiguration = null,

    /// Specifies configurations for storage in Amazon Redshift.
    redshift_configuration: ?RedshiftQueryEngineRedshiftStorageConfiguration = null,

    /// The data storage service to use.
    @"type": RedshiftQueryEngineStorageType,

    pub const json_field_names = .{
        .aws_data_catalog_configuration = "awsDataCatalogConfiguration",
        .redshift_configuration = "redshiftConfiguration",
        .@"type" = "type",
    };
};
