const aws = @import("aws");

const Achievability = @import("achievability.zig").Achievability;
const AssessmentStatus = @import("assessment_status.zig").AssessmentStatus;
const AssociatedSystem = @import("associated_system.zig").AssociatedSystem;
const DependencyDiscoveryConfig = @import("dependency_discovery_config.zig").DependencyDiscoveryConfig;
const EffectivePolicyValues = @import("effective_policy_values.zig").EffectivePolicyValues;
const AssessmentCost = @import("assessment_cost.zig").AssessmentCost;
const PermissionModel = @import("permission_model.zig").PermissionModel;
const ServiceReportConfiguration = @import("service_report_configuration.zig").ServiceReportConfiguration;
const ResourceDiscoveryStatus = @import("resource_discovery_status.zig").ResourceDiscoveryStatus;

/// Represents a service in Resilience Hub. A service is the primary unit of
/// resilience assessment.
pub const Service = struct {
    /// The AWS account ID that owns the service.
    account_id: ?[]const u8 = null,

    /// The achievability status of the service's resilience targets.
    achievability: ?Achievability = null,

    /// The current assessment status of the service.
    assessment_status: ?AssessmentStatus = null,

    /// The systems associated with the service.
    associated_systems: ?[]const AssociatedSystem = null,

    /// The timestamp when the service was created.
    created_at: ?i64 = null,

    /// The dependency discovery configuration for the service.
    dependency_discovery: ?DependencyDiscoveryConfig = null,

    description: ?[]const u8 = null,

    /// The effective policy values for the service.
    effective_policy_values: ?EffectivePolicyValues = null,

    /// The estimated cost of running an assessment on the service.
    estimated_assessment_cost: ?AssessmentCost = null,

    kms_key_id: ?[]const u8 = null,

    name: []const u8,

    /// The number of open findings for the service.
    open_findings_count: ?i32 = null,

    /// The AWS Organizations identifier for the service.
    organization_id: ?[]const u8 = null,

    /// The organizational unit (OU) identifier for the service.
    ou_id: ?[]const u8 = null,

    /// The permission model for the service.
    permission_model: ?PermissionModel = null,

    policy_arn: ?[]const u8 = null,

    /// The Regions where the service operates.
    regions: ?[]const []const u8 = null,

    report_configuration: ?ServiceReportConfiguration = null,

    /// Indicates whether the assessment should be rerun.
    rerun_assessment: ?bool = null,

    /// The number of resolved findings for the service.
    resolved_findings_count: ?i32 = null,

    /// The resource discovery status for the service.
    resource_discovery: ?ResourceDiscoveryStatus = null,

    service_arn: []const u8,

    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the service was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .achievability = "achievability",
        .assessment_status = "assessmentStatus",
        .associated_systems = "associatedSystems",
        .created_at = "createdAt",
        .dependency_discovery = "dependencyDiscovery",
        .description = "description",
        .effective_policy_values = "effectivePolicyValues",
        .estimated_assessment_cost = "estimatedAssessmentCost",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .open_findings_count = "openFindingsCount",
        .organization_id = "organizationId",
        .ou_id = "ouId",
        .permission_model = "permissionModel",
        .policy_arn = "policyArn",
        .regions = "regions",
        .report_configuration = "reportConfiguration",
        .rerun_assessment = "rerunAssessment",
        .resolved_findings_count = "resolvedFindingsCount",
        .resource_discovery = "resourceDiscovery",
        .service_arn = "serviceArn",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};
