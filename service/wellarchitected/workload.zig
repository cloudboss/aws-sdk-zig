const aws = @import("aws");

const WorkloadDiscoveryConfig = @import("workload_discovery_config.zig").WorkloadDiscoveryConfig;
const WorkloadEnvironment = @import("workload_environment.zig").WorkloadEnvironment;
const WorkloadImprovementStatus = @import("workload_improvement_status.zig").WorkloadImprovementStatus;
const WorkloadJiraConfigurationOutput = @import("workload_jira_configuration_output.zig").WorkloadJiraConfigurationOutput;
const WorkloadProfile = @import("workload_profile.zig").WorkloadProfile;

/// A workload return object.
pub const Workload = struct {
    account_ids: ?[]const []const u8,

    /// List of AppRegistry application ARNs associated to the workload.
    applications: ?[]const []const u8,

    architectural_design: ?[]const u8,

    aws_regions: ?[]const []const u8,

    description: ?[]const u8,

    /// Discovery configuration associated to the workload.
    discovery_config: ?WorkloadDiscoveryConfig,

    environment: ?WorkloadEnvironment,

    improvement_status: ?WorkloadImprovementStatus,

    industry: ?[]const u8,

    industry_type: ?[]const u8,

    /// Flag indicating whether the workload owner has acknowledged that the *Review
    /// owner* field is required.
    ///
    /// If a **Review owner** is not added to the workload within
    /// 60 days of acknowledgement, access to the workload is restricted until an
    /// owner is
    /// added.
    is_review_owner_update_acknowledged: ?bool,

    /// Jira configuration for a specific workload.
    jira_configuration: ?WorkloadJiraConfigurationOutput,

    lenses: ?[]const []const u8,

    non_aws_regions: ?[]const []const u8,

    notes: ?[]const u8,

    owner: ?[]const u8,

    pillar_priorities: ?[]const []const u8,

    prioritized_risk_counts: ?[]const aws.map.MapEntry(i32),

    /// Profile associated with a workload.
    profiles: ?[]const WorkloadProfile,

    review_owner: ?[]const u8,

    review_restriction_date: ?i64,

    risk_counts: ?[]const aws.map.MapEntry(i32),

    /// The ID assigned to the share invitation.
    share_invitation_id: ?[]const u8,

    /// The tags associated with the workload.
    tags: ?[]const aws.map.StringMapEntry,

    updated_at: ?i64,

    workload_arn: ?[]const u8,

    workload_id: ?[]const u8,

    workload_name: ?[]const u8,

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
