const Customer = @import("customer.zig").Customer;
const LifeCycleForView = @import("life_cycle_for_view.zig").LifeCycleForView;
const Contact = @import("contact.zig").Contact;
const OpportunityType = @import("opportunity_type.zig").OpportunityType;
const PrimaryNeedFromAws = @import("primary_need_from_aws.zig").PrimaryNeedFromAws;
const ProjectView = @import("project_view.zig").ProjectView;
const RelatedEntityIdentifiers = @import("related_entity_identifiers.zig").RelatedEntityIdentifiers;

/// Provides a comprehensive view of an opportunity summary, including lifecycle
/// information, team details, opportunity type, primary needs from AWS, and
/// associated project information.
pub const OpportunitySummaryView = struct {
    customer: ?Customer = null,

    /// Contains information about the opportunity's lifecycle, including its
    /// current stage, status, and important dates such as creation and last
    /// modification times.
    lifecycle: ?LifeCycleForView = null,

    /// Represents the internal team handling the opportunity. Specify the members
    /// involved in collaborating on an opportunity within the partner's
    /// organization.
    opportunity_team: ?[]const Contact = null,

    /// Specifies the opportunity type.
    opportunity_type: ?OpportunityType = null,

    /// Identifies the type of support the partner needs from AWS.
    primary_needs_from_aws: ?[]const PrimaryNeedFromAws = null,

    /// Contains summary information about the project associated with the
    /// opportunity, including project name, description, timeline, and other
    /// relevant details.
    project: ?ProjectView = null,

    related_entity_identifiers: ?RelatedEntityIdentifiers = null,

    pub const json_field_names = .{
        .customer = "Customer",
        .lifecycle = "Lifecycle",
        .opportunity_team = "OpportunityTeam",
        .opportunity_type = "OpportunityType",
        .primary_needs_from_aws = "PrimaryNeedsFromAws",
        .project = "Project",
        .related_entity_identifiers = "RelatedEntityIdentifiers",
    };
};
