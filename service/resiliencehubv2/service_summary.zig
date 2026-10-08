const Achievability = @import("achievability.zig").Achievability;
const AssessmentStatus = @import("assessment_status.zig").AssessmentStatus;
const AssociatedSystem = @import("associated_system.zig").AssociatedSystem;
const DependencyDiscoveryConfig = @import("dependency_discovery_config.zig").DependencyDiscoveryConfig;

/// Contains summary information about a service.
pub const ServiceSummary = struct {
    /// Displayed only if caller has access.
    account_id: ?[]const u8 = null,

    /// The achievability status of the service's resilience targets.
    achievability: ?Achievability = null,

    /// The current assessment status of the service.
    assessment_status: ?AssessmentStatus = null,

    /// The systems associated with the service.
    associated_systems: ?[]const AssociatedSystem = null,

    /// The timestamp when the service was created.
    created_at: ?i64 = null,

    /// The dependency discovery configuration.
    dependency_discovery: ?DependencyDiscoveryConfig = null,

    name: []const u8,

    /// The number of open findings.
    open_findings_count: ?i32 = null,

    /// Displayed only if caller has access.
    organization_id: ?[]const u8 = null,

    /// Displayed only if caller has access.
    ou_id: ?[]const u8 = null,

    policy_arn: ?[]const u8 = null,

    /// The Regions where the service operates.
    regions: ?[]const []const u8 = null,

    /// The number of resolved findings.
    resolved_findings_count: ?i32 = null,

    service_arn: []const u8,

    /// The timestamp when the service was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .achievability = "achievability",
        .assessment_status = "assessmentStatus",
        .associated_systems = "associatedSystems",
        .created_at = "createdAt",
        .dependency_discovery = "dependencyDiscovery",
        .name = "name",
        .open_findings_count = "openFindingsCount",
        .organization_id = "organizationId",
        .ou_id = "ouId",
        .policy_arn = "policyArn",
        .regions = "regions",
        .resolved_findings_count = "resolvedFindingsCount",
        .service_arn = "serviceArn",
        .updated_at = "updatedAt",
    };
};
