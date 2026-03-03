const aws = @import("aws");

const WorkloadDiscoveryConfig = @import("workload_discovery_config.zig").WorkloadDiscoveryConfig;
const WorkloadEnvironment = @import("workload_environment.zig").WorkloadEnvironment;
const WorkloadImprovementStatus = @import("workload_improvement_status.zig").WorkloadImprovementStatus;
const WorkloadJiraConfigurationOutput = @import("workload_jira_configuration_output.zig").WorkloadJiraConfigurationOutput;
const WorkloadProfile = @import("workload_profile.zig").WorkloadProfile;

/// A workload return object.
pub const Workload = struct {
    account_ids: ?[]const []const u8 = null,

    /// List of AppRegistry application ARNs associated to the workload.
    applications: ?[]const []const u8 = null,

    architectural_design: ?[]const u8 = null,

    aws_regions: ?[]const []const u8 = null,

    description: ?[]const u8 = null,

    /// Discovery configuration associated to the workload.
    discovery_config: ?WorkloadDiscoveryConfig = null,

    environment: ?WorkloadEnvironment = null,

    improvement_status: ?WorkloadImprovementStatus = null,

    industry: ?[]const u8 = null,

    industry_type: ?[]const u8 = null,

    /// Flag indicating whether the workload owner has acknowledged that the *Review
    /// owner* field is required.
    ///
    /// If a **Review owner** is not added to the workload within
    /// 60 days of acknowledgement, access to the workload is restricted until an
    /// owner is
    /// added.
    is_review_owner_update_acknowledged: ?bool = null,

    /// Jira configuration for a specific workload.
    jira_configuration: ?WorkloadJiraConfigurationOutput = null,

    lenses: ?[]const []const u8 = null,

    non_aws_regions: ?[]const []const u8 = null,

    notes: ?[]const u8 = null,

    owner: ?[]const u8 = null,

    pillar_priorities: ?[]const []const u8 = null,

    prioritized_risk_counts: ?[]const aws.map.MapEntry(i32) = null,

    /// Profile associated with a workload.
    profiles: ?[]const WorkloadProfile = null,

    review_owner: ?[]const u8 = null,

    review_restriction_date: ?i64 = null,

    risk_counts: ?[]const aws.map.MapEntry(i32) = null,

    /// The ID assigned to the share invitation.
    share_invitation_id: ?[]const u8 = null,

    /// The tags associated with the workload.
    tags: ?[]const aws.map.StringMapEntry = null,

    updated_at: ?i64 = null,

    workload_arn: ?[]const u8 = null,

    workload_id: ?[]const u8 = null,

    workload_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .applications = "Applications",
        .architectural_design = "ArchitecturalDesign",
        .aws_regions = "AwsRegions",
        .description = "Description",
        .discovery_config = "DiscoveryConfig",
        .environment = "Environment",
        .improvement_status = "ImprovementStatus",
        .industry = "Industry",
        .industry_type = "IndustryType",
        .is_review_owner_update_acknowledged = "IsReviewOwnerUpdateAcknowledged",
        .jira_configuration = "JiraConfiguration",
        .lenses = "Lenses",
        .non_aws_regions = "NonAwsRegions",
        .notes = "Notes",
        .owner = "Owner",
        .pillar_priorities = "PillarPriorities",
        .prioritized_risk_counts = "PrioritizedRiskCounts",
        .profiles = "Profiles",
        .review_owner = "ReviewOwner",
        .review_restriction_date = "ReviewRestrictionDate",
        .risk_counts = "RiskCounts",
        .share_invitation_id = "ShareInvitationId",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
        .workload_arn = "WorkloadArn",
        .workload_id = "WorkloadId",
        .workload_name = "WorkloadName",
    };
};
