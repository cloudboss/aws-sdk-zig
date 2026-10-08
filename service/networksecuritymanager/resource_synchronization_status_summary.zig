const OutOfSyncReasonsView = @import("out_of_sync_reasons_view.zig").OutOfSyncReasonsView;
const RemediationIssuesView = @import("remediation_issues_view.zig").RemediationIssuesView;
const ResourceType = @import("resource_type.zig").ResourceType;
const SynchronizationStatus = @import("synchronization_status.zig").SynchronizationStatus;

/// The synchronization status of a resource covered by a deployment.
pub const ResourceSynchronizationStatusSummary = struct {
    /// The AWS account ID that owns the resource.
    account_id: []const u8,

    /// The ARN of the deployment that the synchronization status is associated
    /// with. This is absent for aggregate (cross-deployment) statuses.
    deployment_arn: ?[]const u8 = null,

    /// The time when the synchronization status was last evaluated.
    evaluated_at: ?i64 = null,

    /// The reasons the resource is out of sync, keyed by firewall type. This is
    /// null when the resource is in sync.
    out_of_sync_reasons: ?OutOfSyncReasonsView = null,

    /// Details about remediation issues, keyed by firewall type. This is null when
    /// there are no remediation issues.
    remediation_issues: ?RemediationIssuesView = null,

    /// The ARN of the resource whose synchronization status is reported.
    resource_arn: []const u8,

    /// The type of the resource, in AWS CloudFormation format.
    resource_type: ?ResourceType = null,

    /// The synchronization status of the resource, such as `IN_SYNC` or
    /// `OUT_OF_SYNC`.
    synchronization_status: SynchronizationStatus,

    /// The time when the resource was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .account_id = "accountId",
        .deployment_arn = "deploymentArn",
        .evaluated_at = "evaluatedAt",
        .out_of_sync_reasons = "outOfSyncReasons",
        .remediation_issues = "remediationIssues",
        .resource_arn = "resourceArn",
        .resource_type = "resourceType",
        .synchronization_status = "synchronizationStatus",
        .updated_at = "updatedAt",
    };
};
