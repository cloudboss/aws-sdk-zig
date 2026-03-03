const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

/// Summary information about a global resolver.
pub const GlobalResolversItem = struct {
    /// The Amazon Resource Name (ARN) of the global resolver.
    arn: []const u8,

    /// The unique string that identifies the request and ensures idempotency.
    client_token: []const u8,

    /// The date and time when the global resolver was created.
    created_at: i64,

    /// A description of the global resolver.
    description: ?[]const u8 = null,

    /// The DNS name of the global resolver.
    dns_name: []const u8,

    /// The unique identifier of the global resolver.
    id: []const u8,

    /// The IPv4 addresses assigned to the global resolver.
    ipv_4_addresses: []const []const u8,

    /// The name of the global resolver.
    name: []const u8,

    /// The AWS Region where observability data is collected for the global
    /// resolver.
    observability_region: ?[]const u8 = null,

    /// The AWS Regions where the global resolver is deployed.
    regions: []const []const u8,

    /// The current status of the global resolver.
    status: CRResourceStatus,

    /// The date and time when the global resolver was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .description = "description",
        .dns_name = "dnsName",
        .id = "id",
        .ipv_4_addresses = "ipv4Addresses",
        .name = "name",
        .observability_region = "observabilityRegion",
        .regions = "regions",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
