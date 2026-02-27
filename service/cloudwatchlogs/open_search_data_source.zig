const OpenSearchResourceStatus = @import("open_search_resource_status.zig").OpenSearchResourceStatus;

/// This structure contains information about the OpenSearch Service data source
/// used for this
/// integration. This data source was created as part of the integration setup.
/// An OpenSearch Service data source defines the source and destination for
/// OpenSearch Service queries. It
/// includes the role required to execute queries and write to collections.
///
/// For more information about OpenSearch Service data sources , see [Creating
/// OpenSearch Service data source integrations with Amazon
/// S3.](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/direct-query-s3-creating.html)
pub const OpenSearchDataSource = struct {
    /// The name of the OpenSearch Service data source.
    data_source_name: ?[]const u8,

    /// This structure contains information about the status of this OpenSearch
    /// Service
    /// resource.
    status: ?OpenSearchResourceStatus,

    pub const json_field_names = .{
        .data_source_name = "dataSourceName",
        .status = "status",
    };
};
