const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// Configuration for Amazon Web Services Security Token Service (STS) access
/// from the ODB network.
pub const StsAccess = struct {
    /// The domain name for Amazon Web Services Security Token Service (STS) access
    /// configuration.
    domain_name: ?[]const u8 = null,

    /// The IPv4 addresses allowed for Amazon Web Services Security Token Service
    /// (STS) access.
    ipv_4_addresses: ?[]const []const u8 = null,

    /// The current status of the Amazon Web Services Security Token Service (STS)
    /// access configuration.
    status: ?ManagedResourceStatus = null,

    /// The Amazon Web Services Security Token Service (STS) policy document that
    /// defines permissions for token service usage.
    sts_policy_document: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .ipv_4_addresses = "ipv4Addresses",
        .status = "status",
        .sts_policy_document = "stsPolicyDocument",
    };
};
