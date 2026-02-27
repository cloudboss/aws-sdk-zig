const HostedZoneAssociationStatus = @import("hosted_zone_association_status.zig").HostedZoneAssociationStatus;

/// Summary information about a hosted zone association.
pub const HostedZoneAssociationSummary = struct {
    /// The date and time when the hosted zone association was created.
    created_at: i64,

    /// The ID of the hosted zone.
    hosted_zone_id: []const u8,

    /// The name of the hosted zone.
    hosted_zone_name: []const u8,

    /// The unique identifier of the hosted zone association.
    id: []const u8,

    /// The name of the hosted zone association.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the resource associated with the hosted
    /// zone.
    resource_arn: []const u8,

    /// The current status of the hosted zone association.
    status: HostedZoneAssociationStatus,

    /// The date and time when the hosted zone association was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .hosted_zone_id = "hostedZoneId",
        .hosted_zone_name = "hostedZoneName",
        .id = "id",
        .name = "name",
        .resource_arn = "resourceArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
