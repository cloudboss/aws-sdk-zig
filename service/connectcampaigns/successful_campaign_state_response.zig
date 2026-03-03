const CampaignState = @import("campaign_state.zig").CampaignState;

/// Successful response of campaign state
pub const SuccessfulCampaignStateResponse = struct {
    campaign_id: ?[]const u8 = null,

    state: ?CampaignState = null,

    pub const json_field_names = .{
        .campaign_id = "campaignId",
        .state = "state",
    };
};
