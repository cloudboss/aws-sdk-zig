const LeadCustomer = @import("lead_customer.zig").LeadCustomer;
const LeadInsights = @import("lead_insights.zig").LeadInsights;
const LeadInteraction = @import("lead_interaction.zig").LeadInteraction;

/// Provides comprehensive details about a lead associated with an engagement.
/// This structure contains information about lead qualification status,
/// customer details, and interaction history to facilitate lead management and
/// tracking within the engagement.
pub const LeadContext = struct {
    /// Contains detailed information about the customer associated with the lead,
    /// including company information, contact details, and other relevant customer
    /// data.
    customer: LeadCustomer,

    /// Insights that AI generates and associates with the lead. These insights
    /// provide automated analysis such as lead readiness scoring to help partners
    /// assess the lead quality.
    insights: ?LeadInsights = null,

    /// An array of interactions that have occurred with the lead, providing a
    /// history of communications, meetings, and other engagement activities related
    /// to the lead.
    interactions: []const LeadInteraction,

    /// Indicates the current qualification status of the lead, such as whether it
    /// has been qualified, disqualified, or is still under evaluation. This helps
    /// track the lead's progression through the qualification process.
    qualification_status: []const u8 = "Unqualified",

    pub const json_field_names = .{
        .customer = "Customer",
        .insights = "Insights",
        .interactions = "Interactions",
        .qualification_status = "QualificationStatus",
    };
};
