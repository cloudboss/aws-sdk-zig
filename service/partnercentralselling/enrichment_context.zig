const LeadInsights = @import("lead_insights.zig").LeadInsights;
const InvitationProspectingResultAws = @import("invitation_prospecting_result_aws.zig").InvitationProspectingResultAws;

/// Contains enrichment data for engagement invitations. You can view propensity
/// scores, program eligibility, and lead readiness insights directly in the
/// invitation, before you take action on the invitation.
pub const EnrichmentContext = struct {
    /// The AI-generated lead readiness score for this lead. Use this score to
    /// assess lead quality and prioritize engagement efforts.
    lead_insights: ?LeadInsights = null,

    /// The customer account data and propensity insights for the prospected
    /// account. It includes geographic, industry, and segment classifications,
    /// along with engagement and solution scoring.
    prospecting_result_aws: ?InvitationProspectingResultAws = null,

    pub const json_field_names = .{
        .lead_insights = "LeadInsights",
        .prospecting_result_aws = "ProspectingResultAws",
    };
};
