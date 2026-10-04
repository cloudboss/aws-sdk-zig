const LeadCustomer = @import("lead_customer.zig").LeadCustomer;
const LeadInsights = @import("lead_insights.zig").LeadInsights;
const LeadInteraction = @import("lead_interaction.zig").LeadInteraction;

/// Updates the context information for a lead with qualification status,
/// customer details, and interaction data.
pub const UpdateLeadContext = struct {
    /// Updated customer information associated with the lead.
    customer: LeadCustomer,

    /// Insights that AI generates and associates with the lead. These insights
    /// provide automated analysis to help partners assess the lead quality and
    /// readiness.
    insights: ?LeadInsights = null,

    /// Updated interaction details for the lead context.
    interaction: ?LeadInteraction = null,

    /// The updated qualification status of the lead.
    qualification_status: []const u8 = "Unqualified",

    pub const json_field_names = .{
        .customer = "Customer",
        .insights = "Insights",
        .interaction = "Interaction",
        .qualification_status = "QualificationStatus",
    };
};
