const ProspectingResultCustomer = @import("prospecting_result_customer.zig").ProspectingResultCustomer;
const ProspectingInsights = @import("prospecting_insights.zig").ProspectingInsights;

/// A subset of prospecting result data visible to invitation receivers. It
/// includes customer account details and AI-generated insights.
pub const InvitationProspectingResultAws = struct {
    /// The prospected customer account details, including geographic
    /// classification, industry segmentation, company size, and program
    /// eligibility.
    customer: ?ProspectingResultCustomer = null,

    /// The AI-generated insights from the prospecting analysis, including
    /// marketplace engagement scoring, solution fit assessments, and solution
    /// categorization.
    insights: ?ProspectingInsights = null,

    pub const json_field_names = .{
        .customer = "Customer",
        .insights = "Insights",
    };
};
