const DomainVersion = @import("domain_version.zig").DomainVersion;
const DomainStatus = @import("domain_status.zig").DomainStatus;

/// A summary of a Amazon DataZone domain.
pub const DomainSummary = struct {
    /// The ARN of the Amazon DataZone domain.
    arn: []const u8,

    /// A timestamp of when a Amazon DataZone domain was created.
    created_at: i64,

    /// A description of an Amazon DataZone domain.
    description: ?[]const u8 = null,

    /// The domain version.
    domain_version: ?DomainVersion = null,

    /// The ID of the Amazon DataZone domain.
    id: []const u8,

    /// A timestamp of when a Amazon DataZone domain was last updated.
    last_updated_at: ?i64 = null,

    /// The identifier of the Amazon Web Services account that manages the domain.
    managed_account_id: []const u8,

    /// A name of an Amazon DataZone domain.
    name: []const u8,

    /// The data portal URL for the Amazon DataZone domain.
    portal_url: ?[]const u8 = null,

    /// The status of the Amazon DataZone domain.
    status: DomainStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .domain_version = "domainVersion",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .managed_account_id = "managedAccountId",
        .name = "name",
        .portal_url = "portalUrl",
        .status = "status",
    };
};
