const ResourceType = @import("resource_type.zig").ResourceType;
const FindingStatus = @import("finding_status.zig").FindingStatus;

/// Contains details about the analyzed resource.
pub const AnalyzedResource = struct {
    /// The actions that an external principal is granted permission to use by the
    /// policy that generated the finding.
    actions: ?[]const []const u8,

    /// The time at which the resource was analyzed.
    analyzed_at: i64,

    /// The time at which the finding was created.
    created_at: i64,

    /// An error message.
    @"error": ?[]const u8,

    /// Indicates whether the policy that generated the finding grants public access
    /// to the resource.
    is_public: bool,

    /// The ARN of the resource that was analyzed.
    resource_arn: []const u8,

    /// The Amazon Web Services account ID that owns the resource.
    resource_owner_account: []const u8,

    /// The type of the resource that was analyzed.
    resource_type: ResourceType,

    /// Indicates how the access that generated the finding is granted. This is
    /// populated for Amazon S3 bucket findings.
    shared_via: ?[]const []const u8,

    /// The current status of the finding generated from the analyzed resource.
    status: ?FindingStatus,

    /// The time at which the finding was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .actions = "actions",
        .analyzed_at = "analyzedAt",
        .created_at = "createdAt",
        .@"error" = "error",
        .is_public = "isPublic",
        .resource_arn = "resourceArn",
        .resource_owner_account = "resourceOwnerAccount",
        .resource_type = "resourceType",
        .shared_via = "sharedVia",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
