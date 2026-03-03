const DNSTargetResource = @import("dns_target_resource.zig").DNSTargetResource;

/// The resource element of a resource set.
pub const Resource = struct {
    /// The component identifier of the resource, generated when DNS target resource
    /// is used.
    component_id: ?[]const u8 = null,

    /// The DNS target resource.
    dns_target_resource: ?DNSTargetResource = null,

    /// A list of recovery group Amazon Resource Names (ARNs) and cell ARNs that
    /// this resource is contained within.
    readiness_scopes: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services resource.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .component_id = "ComponentId",
        .dns_target_resource = "DnsTargetResource",
        .readiness_scopes = "ReadinessScopes",
        .resource_arn = "ResourceArn",
    };
};
