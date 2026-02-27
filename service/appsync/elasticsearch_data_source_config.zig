/// Describes an OpenSearch data source configuration.
///
/// As of September 2021, Amazon Elasticsearch service is Amazon OpenSearch
/// Service. This
/// configuration is deprecated. For new data sources, use
/// OpenSearchServiceDataSourceConfig to specify an OpenSearch data
/// source.
pub const ElasticsearchDataSourceConfig = struct {
    /// The Amazon Web Services Region.
    aws_region: []const u8,

    /// The endpoint.
    endpoint: []const u8,

    pub const json_field_names = .{
        .aws_region = "awsRegion",
        .endpoint = "endpoint",
    };
};
