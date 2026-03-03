const OpenSearchResourceStatus = @import("open_search_resource_status.zig").OpenSearchResourceStatus;

/// This structure contains information about the OpenSearch Service encryption
/// policy used
/// for this integration. The encryption policy was created automatically when
/// you created the
/// integration. For more information, see [Encryption
/// policies](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-encryption.html#serverless-encryption-policies) in the OpenSearch Service Developer Guide.
pub const OpenSearchEncryptionPolicy = struct {
    /// The name of the encryption policy.
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
