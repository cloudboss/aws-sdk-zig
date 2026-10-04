const aws = @import("aws");

const AggregationConfiguration = @import("aggregation_configuration.zig").AggregationConfiguration;
const Pillar = @import("pillar.zig").Pillar;
const Tag = @import("tag.zig").Tag;

/// Summary of an optimization profile, including its configuration, metadata,
/// and audit information.
pub const AgentProfileSummary = struct {
    /// The aggregation configuration that defines which Amazon Web Services
    /// accounts and Regions to analyze.
    aggregation_configuration: []const AggregationConfiguration,

    /// The Amazon Resource Name (ARN) of the optimization profile.
    arn: []const u8,

    /// The business overview for this profile.
    business_overview: ?[]const u8 = null,

    /// The timestamp when the profile was created.
    created_at: i64,

    /// The identifier of the user or system that created this profile.
    created_by: []const u8,

    /// Indicates whether deletion protection is enabled for the profile.
    deletion_protection: bool = true,

    /// A description of the profile.
    description: ?[]const u8 = null,

    /// The display name of the profile shown to users.
    display_name: ?[]const u8 = null,

    /// Indicates whether the profile is valid for manual architecture generation.
    eligible_for_architecture_generation: ?bool = null,

    /// Indicates whether the profile is valid for scheduled recommendation
    /// generation.
    eligible_for_scheduled_generation: ?bool = null,

    /// The ARN of the IAM execution role used for recommendation actions.
    execution_role_arn: []const u8,

    /// A map of field paths to error messages for invalid or missing input fields.
    field_errors: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the profile was last modified.
    last_modified_at: ?i64 = null,

    /// The identifier of the user or system that last modified this profile.
    last_modified_by: ?[]const u8 = null,

    /// The system name of the profile.
    name: []const u8,

    /// The Well-Architected Tool Framework pillars associated with this profile.
    pillars: []const Pillar,

    /// The tags associated with the profile.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aggregation_configuration = "aggregationConfiguration",
        .arn = "arn",
        .business_overview = "businessOverview",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .deletion_protection = "deletionProtection",
        .description = "description",
        .display_name = "displayName",
        .eligible_for_architecture_generation = "eligibleForArchitectureGeneration",
        .eligible_for_scheduled_generation = "eligibleForScheduledGeneration",
        .execution_role_arn = "executionRoleArn",
        .field_errors = "fieldErrors",
        .last_modified_at = "lastModifiedAt",
        .last_modified_by = "lastModifiedBy",
        .name = "name",
        .pillars = "pillars",
        .tags = "tags",
    };
};
