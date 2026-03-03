const OpenSearchResourceStatus = @import("open_search_resource_status.zig").OpenSearchResourceStatus;

/// This structure contains information about the OpenSearch Service network
/// policy used for
/// this integration. The network policy assigns network access settings to
/// collections. For more
/// information, see [Network
/// policies](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-network.html#serverless-network-policies) in the OpenSearch Service Developer Guide.
pub const OpenSearchNetworkPolicy = struct {
    /// The name of the network policy.
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
