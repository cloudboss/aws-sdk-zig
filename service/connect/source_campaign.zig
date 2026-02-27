/// Information about the campaign.
pub const SourceCampaign = struct {
    /// A unique identifier for a campaign.
    campaign_id: ?[]const u8,

    /// A unique identifier for a each request part of same campaign.
    outbound_request_id: ?[]const u8,

    pub const json_field_names = .{
        .campaign_id = "CampaignId",
        .outbound_request_id = "OutboundRequestId",
    };
};
