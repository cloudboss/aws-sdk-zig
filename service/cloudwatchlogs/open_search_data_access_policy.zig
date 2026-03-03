const OpenSearchResourceStatus = @import("open_search_resource_status.zig").OpenSearchResourceStatus;

/// This structure contains information about the OpenSearch Service data access
/// policy used
/// for this integration. The access policy defines the access controls for the
/// collection. This
/// data access policy was automatically created as part of the integration
/// setup. For more
/// information about OpenSearch Service data access policies, see [Data access
/// control for Amazon OpenSearch
/// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-data-access.html) in the OpenSearch Service Developer
/// Guide.
pub const OpenSearchDataAccessPolicy = struct {
    /// The name of the data access policy.
    policy_name: ?[]const u8 = null,

    /// This structure contains information about the status of this OpenSearch
    /// Service
    /// resource.
    status: ?OpenSearchResourceStatus = null,

    pub const json_field_names = .{
        .policy_name = "policyName",
        .status = "status",
    };
};
