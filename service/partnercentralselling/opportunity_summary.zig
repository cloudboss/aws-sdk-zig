const CustomerSummary = @import("customer_summary.zig").CustomerSummary;
const LifeCycleSummary = @import("life_cycle_summary.zig").LifeCycleSummary;
const OpportunityType = @import("opportunity_type.zig").OpportunityType;
const ProjectSummary = @import("project_summary.zig").ProjectSummary;

/// An object that contains an `Opportunity`'s subset of fields.
pub const OpportunitySummary = struct {
    /// The Amazon Resource Name (ARN) for the opportunity. This globally unique
    /// identifier can be used for IAM policies and cross-service references.
    arn: ?[]const u8 = null,

    /// Specifies the catalog associated with the opportunity, either `AWS` or
    /// `Sandbox`. This indicates the environment in which the opportunity is
    /// managed.
    catalog: []const u8,

    /// `DateTime` when the `Opportunity` was last created.
    created_date: ?i64 = null,

    /// An object that contains the `Opportunity`'s customer details.
    customer: ?CustomerSummary = null,

    /// Read-only, system-generated `Opportunity` unique identifier.
    id: ?[]const u8 = null,

    /// `DateTime` when the `Opportunity` was last modified.
    last_modified_date: ?i64 = null,

    /// An object that contains the `Opportunity`'s lifecycle details.
    life_cycle: ?LifeCycleSummary = null,

    /// Specifies opportunity type as a renewal, new, or expansion.
    ///
    /// Opportunity types:
    ///
    /// * New Opportunity: Represents a new business opportunity with a potential
    ///   customer that's not previously engaged with your solutions or services.
    /// * Renewal Opportunity: Represents an opportunity to renew an existing
    ///   contract or subscription with a current customer, ensuring continuity of
    ///   service.
    /// * Expansion Opportunity: Represents an opportunity to expand the scope of an
    ///   existing contract or subscription, either by adding new services or
    ///   increasing the volume of existing services for a current customer.
    opportunity_type: ?OpportunityType = null,

    /// Specifies the `Opportunity`'s unique identifier in the partner's CRM system.
    /// This value is essential to track and reconcile because it's included in the
    /// outbound payload sent back to the partner. It allows partners to link an
    /// opportunity to their CRM.
    partner_opportunity_identifier: ?[]const u8 = null,

    /// An object that contains the `Opportunity`'s project details summary.
    project: ?ProjectSummary = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .created_date = "CreatedDate",
        .customer = "Customer",
        .id = "Id",
        .last_modified_date = "LastModifiedDate",
        .life_cycle = "LifeCycle",
        .opportunity_type = "OpportunityType",
        .partner_opportunity_identifier = "PartnerOpportunityIdentifier",
        .project = "Project",
    };
};
