const OpenSearchIntegrationDetails = @import("open_search_integration_details.zig").OpenSearchIntegrationDetails;

/// This structure contains information about the integration configuration. For
/// an
/// integration with OpenSearch Service, this includes information about
/// OpenSearch Service
/// resources such as the collection, the workspace, and policies.
///
/// This structure is returned by a
/// [GetIntegration](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_GetIntegration.html) operation.
pub const IntegrationDetails = union(enum) {
    /// This structure contains complete information about one integration between
    /// CloudWatch Logs and OpenSearch Service.
    open_search_integration_details: ?OpenSearchIntegrationDetails,

    pub const json_field_names = .{
        .open_search_integration_details = "openSearchIntegrationDetails",
    };
};
