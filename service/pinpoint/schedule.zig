const CampaignEventFilter = @import("campaign_event_filter.zig").CampaignEventFilter;
const Frequency = @import("frequency.zig").Frequency;
const QuietTime = @import("quiet_time.zig").QuietTime;

/// Specifies the schedule settings for a campaign.
pub const Schedule = struct {
    /// The scheduled time, in ISO 8601 format, when the campaign ended or will end.
    end_time: ?[]const u8 = null,

    /// The type of event that causes the campaign to be sent, if the value of the
    /// Frequency property is EVENT.
    event_filter: ?CampaignEventFilter = null,

    /// Specifies how often the campaign is sent or whether the campaign is sent in
    /// response to a specific event.
    frequency: ?Frequency = null,

    /// Specifies whether the start and end times for the campaign schedule use each
    /// recipient's local time. To base the schedule on each recipient's local time,
    /// set this value to true.
    is_local_time: ?bool = null,

    /// The default quiet time for the campaign. Quiet time is a specific time range
    /// when a campaign doesn't send messages to endpoints, if all the following
    /// conditions are met:
    ///
    /// * The EndpointDemographic.Timezone property of the endpoint is set to a
    ///   valid value.
    /// * The current time in the endpoint's time zone is later than or equal to the
    ///   time specified by the QuietTime.Start property for the campaign.
    /// * The current time in the endpoint's time zone is earlier than or equal to
    ///   the time specified by the QuietTime.End property for the campaign.
    ///
    /// If any of the preceding conditions isn't met, the endpoint will receive
    /// messages from the campaign, even if quiet time is enabled.
    quiet_time: ?QuietTime = null,

    /// The scheduled time when the campaign began or will begin. Valid values are:
    /// IMMEDIATE, to start the campaign immediately; or, a specific time in ISO
    /// 8601 format.
    start_time: []const u8,

    /// The starting UTC offset for the campaign schedule, if the value of the
    /// IsLocalTime property is true. Valid values are: UTC, UTC+01, UTC+02, UTC+03,
    /// UTC+03:30, UTC+04, UTC+04:30, UTC+05,
    /// UTC+05:30, UTC+05:45, UTC+06, UTC+06:30, UTC+07, UTC+08, UTC+09, UTC+09:30,
    /// UTC+10, UTC+10:30, UTC+11, UTC+12, UTC+13, UTC-02, UTC-03, UTC-04, UTC-05,
    /// UTC-06,
    /// UTC-07, UTC-08, UTC-09, UTC-10, and UTC-11.
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .event_filter = "EventFilter",
        .frequency = "Frequency",
        .is_local_time = "IsLocalTime",
        .quiet_time = "QuietTime",
        .start_time = "StartTime",
        .timezone = "Timezone",
    };
};
