const Customizations = @import("customizations.zig").Customizations;
const DomainResult = @import("domain_result.zig").DomainResult;
const Parameter = @import("parameter.zig").Parameter;
const Tags = @import("tags.zig").Tags;

/// The distribution tenant.
pub const DistributionTenant = struct {
    /// The Amazon Resource Name (ARN) of the distribution tenant.
    arn: ?[]const u8 = null,

    /// The ID of the connection group for the distribution tenant. If you don't
    /// specify a connection group, CloudFront uses the default connection group.
    connection_group_id: ?[]const u8 = null,

    /// The date and time when the distribution tenant was created.
    created_time: ?i64 = null,

    /// Customizations for the distribution tenant. For each distribution tenant,
    /// you can specify the geographic restrictions, and the Amazon Resource Names
    /// (ARNs) for the ACM certificate and WAF web ACL. These are specific values
    /// that you can override or disable from the multi-tenant distribution that was
    /// used to create the distribution tenant.
    customizations: ?Customizations = null,

    /// The ID of the multi-tenant distribution.
    distribution_id: ?[]const u8 = null,

    /// The domains associated with the distribution tenant.
    domains: ?[]const DomainResult = null,

    /// Indicates whether the distribution tenant is in an enabled state. If
    /// disabled, the distribution tenant won't serve traffic.
    enabled: ?bool = null,

    /// The ID of the distribution tenant.
    id: ?[]const u8 = null,

    /// The date and time when the distribution tenant was updated.
    last_modified_time: ?i64 = null,

    /// The name of the distribution tenant.
    name: ?[]const u8 = null,

    /// A list of parameter values to add to the resource. A parameter is specified
    /// as a key-value pair. A valid parameter value must exist for any parameter
    /// that is marked as required in the multi-tenant distribution.
    parameters: ?[]const Parameter = null,

    /// The status of the distribution tenant.
    status: ?[]const u8 = null,

    tags: ?Tags = null,
};
