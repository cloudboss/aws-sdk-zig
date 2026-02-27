const LeadInvitationPayload = @import("lead_invitation_payload.zig").LeadInvitationPayload;
const OpportunityInvitationPayload = @import("opportunity_invitation_payload.zig").OpportunityInvitationPayload;

/// Contains the data payload associated with the Engagement Invitation. This
/// payload includes essential details related to the AWS opportunity and is
/// used by partners to evaluate whether to accept or reject the engagement.
pub const Payload = union(enum) {
    /// Specifies the details of the lead invitation within the Engagement
    /// Invitation payload. This data helps partners understand the lead context,
    /// customer information, and interaction history for the lead opportunity from
    /// AWS.
    lead_invitation: ?LeadInvitationPayload,
    /// Specifies the details of the opportunity invitation within the Engagement
    /// Invitation payload. This data helps partners understand the context, scope,
    /// and expected involvement for the opportunity from AWS.
    opportunity_invitation: ?OpportunityInvitationPayload,

    pub const json_field_names = .{
        .lead_invitation = "LeadInvitation",
        .opportunity_invitation = "OpportunityInvitation",
    };
};
