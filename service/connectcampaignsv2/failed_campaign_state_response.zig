const GetCampaignStateBatchFailureCode = @import("get_campaign_state_batch_failure_code.zig").GetCampaignStateBatchFailureCode;

/// Failed response of campaign state
pub const FailedCampaignStateResponse = struct {
    campaign_id: ?[]const u8 = null,

    failure_code: ?GetCampaignStateBatchFailureCode = null,

    pub const json_field_names = .{
        .campaign_id = "campaignId",
        .failure_code = "failureCode",
    };
};
