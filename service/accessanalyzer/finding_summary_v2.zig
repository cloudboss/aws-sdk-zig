const FindingType = @import("finding_type.zig").FindingType;
const ResourceType = @import("resource_type.zig").ResourceType;
const FindingStatus = @import("finding_status.zig").FindingStatus;

/// Contains information about a finding.
pub const FindingSummaryV2 = struct {
    /// The time at which the resource-based policy or IAM entity that generated the
    /// finding was analyzed.
    analyzed_at: i64,

    /// The time at which the finding was created.
    created_at: i64,

    /// The error that resulted in an Error finding.
    @"error": ?[]const u8,

    /// The type of the access finding. For external access analyzers, the type is
    /// `ExternalAccess`. For unused access analyzers, the type can be
    /// `UnusedIAMRole`, `UnusedIAMUserAccessKey`, `UnusedIAMUserPassword`, or
    /// `UnusedPermission`. For internal access analyzers, the type is
    /// `InternalAccess`.
    finding_type: ?FindingType,

    /// The ID of the finding.
    id: []const u8,

    /// The resource that the external principal has access to.
    resource: ?[]const u8,

    /// The Amazon Web Services account ID that owns the resource.
    resource_owner_account: []const u8,

    /// The type of the resource that the external principal has access to.
    resource_type: ResourceType,

    /// The status of the finding.
    status: FindingStatus,

    /// The time at which the finding was most recently updated.
    updated_at: i64,

    pub const json_field_names = .{
        .analyzed_at = "analyzedAt",
        .created_at = "createdAt",
        .@"error" = "error",
        .finding_type = "findingType",
        .id = "id",
        .resource = "resource",
        .resource_owner_account = "resourceOwnerAccount",
        .resource_type = "resourceType",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
