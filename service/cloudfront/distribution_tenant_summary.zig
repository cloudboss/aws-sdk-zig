const Customizations = @import("customizations.zig").Customizations;
const DomainResult = @import("domain_result.zig").DomainResult;

/// A summary of the information about a distribution tenant.
pub const DistributionTenantSummary = struct {
    /// The Amazon Resource Name (ARN) of the distribution tenant.
    arn: []const u8,

    /// The ID of the connection group ID for the distribution tenant. If you don't
    /// specify a connection group, CloudFront uses the default connection group.
    connection_group_id: ?[]const u8 = null,

    /// The date and time when the distribution tenant was created.
    created_time: i64,

    /// Customizations for the distribution tenant. For each distribution tenant,
    /// you can specify the geographic restrictions, and the Amazon Resource Names
    /// (ARNs) for the ACM certificate and WAF web ACL. These are specific values
    /// that you can override or disable from the multi-tenant distribution that was
    /// used to create the distribution tenant.
    customizations: ?Customizations = null,

    /// The identifier for the multi-tenant distribution. For example:
    /// `EDFDVBD632BHDS5`.
    distribution_id: []const u8,

    /// The domains associated with the distribution tenant.
    domains: []const DomainResult,

    /// Indicates whether the distribution tenants are in an enabled state. If
    /// disabled, the distribution tenant won't service traffic.
    enabled: ?bool = null,

    /// The current version of the distribution tenant.
    e_tag: []const u8,

    /// The ID of the distribution tenant.
    id: []const u8,

    /// The date and time when the distribution tenant was updated.
    last_modified_time: i64,

    /// The name of the distribution tenant.
    name: []const u8,

    /// The status of the distribution tenant.
    status: ?[]const u8 = null,
};
