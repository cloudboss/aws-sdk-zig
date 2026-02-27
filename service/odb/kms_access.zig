const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// Configuration for Amazon Web Services Key Management Service (KMS) access
/// from the ODB network.
pub const KmsAccess = struct {
    /// The domain name for Amazon Web Services Key Management Service (KMS) access
    /// configuration.
    domain_name: ?[]const u8,

    /// The IPv4 addresses allowed for Amazon Web Services Key Management Service
    /// (KMS) access.
    ipv_4_addresses: ?[]const []const u8,

    /// The Amazon Web Services Key Management Service (KMS) policy document that
    /// defines permissions for key usage.
    kms_policy_document: ?[]const u8,

    /// The current status of the Amazon Web Services Key Management Service (KMS)
    /// access configuration.
    status: ?ManagedResourceStatus,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .ipv_4_addresses = "ipv4Addresses",
        .kms_policy_document = "kmsPolicyDocument",
        .status = "status",
    };
};
