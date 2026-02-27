const aws = @import("aws");

const ResourceControlPolicyRestriction = @import("resource_control_policy_restriction.zig").ResourceControlPolicyRestriction;
const ResourceType = @import("resource_type.zig").ResourceType;
const FindingSource = @import("finding_source.zig").FindingSource;
const FindingStatus = @import("finding_status.zig").FindingStatus;

/// Contains information about a finding.
pub const FindingSummary = struct {
    /// The action in the analyzed policy statement that an external principal has
    /// permission to use.
    action: ?[]const []const u8,

    /// The time at which the resource-based policy that generated the finding was
    /// analyzed.
    analyzed_at: i64,

    /// The condition in the analyzed policy statement that resulted in a finding.
    condition: []const aws.map.StringMapEntry,

    /// The time at which the finding was created.
    created_at: i64,

    /// The error that resulted in an Error finding.
    @"error": ?[]const u8,

    /// The ID of the finding.
    id: []const u8,

    /// Indicates whether the finding reports a resource that has a policy that
    /// allows public access.
    is_public: ?bool,

    /// The external principal that has access to a resource within the zone of
    /// trust.
    principal: ?[]const aws.map.StringMapEntry,

    /// The resource that the external principal has access to.
    resource: ?[]const u8,

    /// The type of restriction applied to the finding by the resource owner with an
    /// Organizations resource control policy (RCP).
    resource_control_policy_restriction: ?ResourceControlPolicyRestriction,

    /// The Amazon Web Services account ID that owns the resource.
    resource_owner_account: []const u8,

    /// The type of the resource that the external principal has access to.
    resource_type: ResourceType,

    /// The sources of the finding. This indicates how the access that generated the
    /// finding is granted. It is populated for Amazon S3 bucket findings.
    sources: ?[]const FindingSource,

    /// The status of the finding.
    status: FindingStatus,

    /// The time at which the finding was most recently updated.
    updated_at: i64,

    pub const json_field_names = .{
        .action = "action",
        .analyzed_at = "analyzedAt",
        .condition = "condition",
        .created_at = "createdAt",
        .@"error" = "error",
        .id = "id",
        .is_public = "isPublic",
        .principal = "principal",
        .resource = "resource",
        .resource_control_policy_restriction = "resourceControlPolicyRestriction",
        .resource_owner_account = "resourceOwnerAccount",
        .resource_type = "resourceType",
        .sources = "sources",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
