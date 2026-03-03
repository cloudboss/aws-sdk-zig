const CampaignEventFilter = @import("campaign_event_filter.zig").CampaignEventFilter;
const QuietTime = @import("quiet_time.zig").QuietTime;

/// Schedule of the campaign.
pub const InAppCampaignSchedule = struct {
    /// The scheduled time after which the in-app message should not be shown.
    /// Timestamp is in ISO 8601 format.
    end_date: ?[]const u8 = null,

    /// The event filter the SDK has to use to show the in-app message in the
    /// application.
    event_filter: ?CampaignEventFilter = null,

    /// Time during which the in-app message should not be shown to the user.
    quiet_time: ?QuietTime = null,

    pub const json_field_names = .{
        .end_date = "EndDate",
        .event_filter = "EventFilter",
        .quiet_time = "QuietTime",
    };
};
