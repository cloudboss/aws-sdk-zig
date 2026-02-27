const DynamodbDataSourceConfig = @import("dynamodb_data_source_config.zig").DynamodbDataSourceConfig;
const ElasticsearchDataSourceConfig = @import("elasticsearch_data_source_config.zig").ElasticsearchDataSourceConfig;
const EventBridgeDataSourceConfig = @import("event_bridge_data_source_config.zig").EventBridgeDataSourceConfig;
const HttpDataSourceConfig = @import("http_data_source_config.zig").HttpDataSourceConfig;
const LambdaDataSourceConfig = @import("lambda_data_source_config.zig").LambdaDataSourceConfig;
const DataSourceLevelMetricsConfig = @import("data_source_level_metrics_config.zig").DataSourceLevelMetricsConfig;
const OpenSearchServiceDataSourceConfig = @import("open_search_service_data_source_config.zig").OpenSearchServiceDataSourceConfig;
const RelationalDatabaseDataSourceConfig = @import("relational_database_data_source_config.zig").RelationalDatabaseDataSourceConfig;
const DataSourceType = @import("data_source_type.zig").DataSourceType;

/// Describes a data source.
pub const DataSource = struct {
    /// The data source Amazon Resource Name (ARN).
    data_source_arn: ?[]const u8,

    /// The description of the data source.
    description: ?[]const u8,

    /// DynamoDB settings.
    dynamodb_config: ?DynamodbDataSourceConfig,

    /// Amazon OpenSearch Service settings.
    elasticsearch_config: ?ElasticsearchDataSourceConfig,

    /// Amazon EventBridge settings.
    event_bridge_config: ?EventBridgeDataSourceConfig,

    /// HTTP endpoint settings.
    http_config: ?HttpDataSourceConfig,

    /// Lambda settings.
    lambda_config: ?LambdaDataSourceConfig,

    /// Enables or disables enhanced data source metrics for specified data sources.
    /// Note that
    /// `metricsConfig` won't be used unless the
    /// `dataSourceLevelMetricsBehavior` value is set to
    /// `PER_DATA_SOURCE_METRICS`. If the `dataSourceLevelMetricsBehavior`
    /// is set to `FULL_REQUEST_DATA_SOURCE_METRICS` instead, `metricsConfig`
    /// will be ignored. However, you can still set its value.
    ///
    /// `metricsConfig` can be `ENABLED` or `DISABLED`.
    metrics_config: ?DataSourceLevelMetricsConfig,

    /// The name of the data source.
    name: ?[]const u8,

    /// Amazon OpenSearch Service settings.
    open_search_service_config: ?OpenSearchServiceDataSourceConfig,

    /// Relational database settings.
    relational_database_config: ?RelationalDatabaseDataSourceConfig,

    /// The Identity and Access Management (IAM) service role Amazon Resource Name
    /// (ARN)
    /// for the data source. The system assumes this role when accessing the data
    /// source.
    service_role_arn: ?[]const u8,

    /// The type of the data source.
    ///
    /// * **AWS_LAMBDA**: The data source is an Lambda function.
    ///
    /// * **AMAZON_DYNAMODB**: The data source is an Amazon DynamoDB table.
    ///
    /// * **AMAZON_ELASTICSEARCH**: The data source is an
    /// Amazon OpenSearch Service domain.
    ///
    /// * **AMAZON_OPENSEARCH_SERVICE**: The data source is
    /// an Amazon OpenSearch Service domain.
    ///
    /// * **AMAZON_EVENTBRIDGE**: The data source is an
    /// Amazon EventBridge configuration.
    ///
    /// * **AMAZON_BEDROCK_RUNTIME**: The data source is the
    /// Amazon Bedrock runtime.
    ///
    /// * **NONE**: There is no data source. Use this type
    /// when you want to invoke a GraphQL operation without connecting to a data
    /// source, such
    /// as when you're performing data transformation with resolvers or invoking a
    /// subscription from a mutation.
    ///
    /// * **HTTP**: The data source is an HTTP
    /// endpoint.
    ///
    /// * **RELATIONAL_DATABASE**: The data source is a
    /// relational database.
    @"type": ?DataSourceType,

    pub const json_field_names = .{
        .data_source_arn = "dataSourceArn",
        .description = "description",
        .dynamodb_config = "dynamodbConfig",
        .elasticsearch_config = "elasticsearchConfig",
        .event_bridge_config = "eventBridgeConfig",
        .http_config = "httpConfig",
        .lambda_config = "lambdaConfig",
        .metrics_config = "metricsConfig",
        .name = "name",
        .open_search_service_config = "openSearchServiceConfig",
        .relational_database_config = "relationalDatabaseConfig",
        .service_role_arn = "serviceRoleArn",
        .@"type" = "type",
    };
};
