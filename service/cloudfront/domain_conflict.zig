const DistributionResourceType = @import("distribution_resource_type.zig").DistributionResourceType;

/// Contains information about the domain conflict. Use this information to
/// determine the affected domain, the related resource, and the affected Amazon
/// Web Services account.
pub const DomainConflict = struct {
    /// The ID of the Amazon Web Services account for the domain conflict.
    account_id: []const u8,

    /// The domain used to find existing conflicts for domain configurations.
    domain: []const u8,

    /// The ID of the resource that has a domain conflict.
    resource_id: []const u8,

    /// The CloudFront resource type that has a domain conflict.
    resource_type: DistributionResourceType,
};
