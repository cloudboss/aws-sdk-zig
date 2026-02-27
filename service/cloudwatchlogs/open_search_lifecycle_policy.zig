const OpenSearchResourceStatus = @import("open_search_resource_status.zig").OpenSearchResourceStatus;

/// This structure contains information about the OpenSearch Service data
/// lifecycle policy
/// used for this integration. The lifecycle policy determines the lifespan of
/// the data in the
/// collection. It was automatically created as part of the integration setup.
///
/// For more information, see [Using data
/// lifecycle policies with OpenSearch Service
/// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-lifecycle.html) in the OpenSearch Service
/// Developer Guide.
pub const OpenSearchLifecyclePolicy = struct {
    /// The name of the lifecycle policy.
    policy_name: ?[]const u8,

    /// This structure contains information about the status of this OpenSearch
    /// Service
    /// resource.
    status: ?OpenSearchResourceStatus,

    pub const json_field_names = .{
        .policy_name = "policyName",
        .status = "status",
    };
};
