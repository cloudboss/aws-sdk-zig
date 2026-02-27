const CampaignStatus = @import("campaign_status.zig").CampaignStatus;

/// Provides information about the status of a campaign.
pub const CampaignState = struct {
    /// The current status of the campaign, or the current status of a treatment
    /// that belongs to an A/B test campaign.
    ///
    /// If a campaign uses A/B testing, the campaign has a status of COMPLETED only
    /// if all campaign treatments have a status of COMPLETED. If you delete the
    /// segment that's associated with a campaign, the campaign fails and has a
    /// status of DELETED.
    campaign_status: ?CampaignStatus,

    pub const json_field_names = .{
        .campaign_status = "CampaignStatus",
    };
};
