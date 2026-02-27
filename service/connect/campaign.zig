/// Information associated with a campaign.
pub const Campaign = struct {
    /// A unique identifier for a campaign.
    campaign_id: ?[]const u8,

    pub const json_field_names = .{
        .campaign_id = "CampaignId",
    };
};
