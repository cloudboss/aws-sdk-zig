const AwsOpportunityCustomer = @import("aws_opportunity_customer.zig").AwsOpportunityCustomer;
const AwsOpportunityInsights = @import("aws_opportunity_insights.zig").AwsOpportunityInsights;
const SalesInvolvementType = @import("sales_involvement_type.zig").SalesInvolvementType;
const InvolvementTypeChangeReason = @import("involvement_type_change_reason.zig").InvolvementTypeChangeReason;
const AwsOpportunityLifeCycle = @import("aws_opportunity_life_cycle.zig").AwsOpportunityLifeCycle;
const AwsTeamMember = @import("aws_team_member.zig").AwsTeamMember;
const OpportunityOrigin = @import("opportunity_origin.zig").OpportunityOrigin;
const AwsOpportunityProject = @import("aws_opportunity_project.zig").AwsOpportunityProject;
const AwsOpportunityRelatedEntities = @import("aws_opportunity_related_entities.zig").AwsOpportunityRelatedEntities;
const Visibility = @import("visibility.zig").Visibility;

/// Provides a comprehensive view of AwsOpportunitySummaryFullView template.
pub const AwsOpportunitySummaryFullView = struct {
    customer: ?AwsOpportunityCustomer,

    insights: ?AwsOpportunityInsights,

    /// Type of AWS involvement in the opportunity.
    involvement_type: ?SalesInvolvementType,

    /// Reason for changes in AWS involvement type for the opportunity.
    involvement_type_change_reason: ?InvolvementTypeChangeReason,

    life_cycle: ?AwsOpportunityLifeCycle,

    /// AWS team members involved in the opportunity.
    opportunity_team: ?[]const AwsTeamMember,

    /// Source origin of the AWS opportunity.
    origin: ?OpportunityOrigin,

    project: ?AwsOpportunityProject,

    related_entity_ids: ?AwsOpportunityRelatedEntities,

    /// Identifier of the related partner opportunity.
    related_opportunity_id: ?[]const u8,

    /// Visibility level for the AWS opportunity.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .customer = "Customer",
        .insights = "Insights",
        .involvement_type = "InvolvementType",
        .involvement_type_change_reason = "InvolvementTypeChangeReason",
        .life_cycle = "LifeCycle",
        .opportunity_team = "OpportunityTeam",
        .origin = "Origin",
        .project = "Project",
        .related_entity_ids = "RelatedEntityIds",
        .related_opportunity_id = "RelatedOpportunityId",
        .visibility = "Visibility",
    };
};
