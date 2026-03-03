const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// The configuration for Amazon S3 access from the ODB network.
pub const S3Access = struct {
    /// The domain name for the Amazon S3 access.
    domain_name: ?[]const u8 = null,

    /// The IPv4 addresses for the Amazon S3 access.
    ipv_4_addresses: ?[]const []const u8 = null,

    /// The endpoint policy for the Amazon S3 access.
    s_3_policy_document: ?[]const u8 = null,

    /// The status of the Amazon S3 access.
    status: ?ManagedResourceStatus = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .ipv_4_addresses = "ipv4Addresses",
        .s_3_policy_document = "s3PolicyDocument",
        .status = "status",
    };
};
