pub const EngagementInvitationPayloadType = enum {
    opportunity_invitation,
    lead_invitation,

    pub const json_field_names = .{
        .opportunity_invitation = "OPPORTUNITY_INVITATION",
        .lead_invitation = "LEAD_INVITATION",
    };
};
