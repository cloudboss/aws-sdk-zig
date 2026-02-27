const OpenSearchResourceStatus = @import("open_search_resource_status.zig").OpenSearchResourceStatus;

/// This structure contains information about the OpenSearch Service collection
/// used for this
/// integration. An OpenSearch Service collection is a logical grouping of one
/// or more indexes
/// that represent an analytics workload. For more information, see [Creating
/// and
/// managing OpenSearch Service Serverless
/// collections](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-collections.html).
pub const OpenSearchCollection = struct {
    /// The ARN of the collection.
    collection_arn: ?[]const u8,

    /// The endpoint of the collection.
    collection_endpoint: ?[]const u8,

    /// This structure contains information about the status of this OpenSearch
    /// Service
    /// resource.
    status: ?OpenSearchResourceStatus,

    pub const json_field_names = .{
        .collection_arn = "collectionArn",
        .collection_endpoint = "collectionEndpoint",
        .status = "status",
    };
};
