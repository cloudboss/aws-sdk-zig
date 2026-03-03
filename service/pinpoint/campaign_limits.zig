/// For a campaign, specifies limits on the messages that the campaign can send.
/// For an application, specifies the default limits for messages that campaigns
/// in the application can send.
pub const CampaignLimits = struct {
    /// The maximum number of messages that a campaign can send to a single endpoint
    /// during a 24-hour period. For an application, this value specifies the
    /// default limit for the number of messages that campaigns and journeys can
    /// send to a single endpoint during a 24-hour period. The maximum value is 100.
    daily: ?i32 = null,

    /// The maximum amount of time, in seconds, that a campaign can attempt to
    /// deliver a message after the scheduled start time for the campaign. The
    /// minimum value is 60 seconds.
    maximum_duration: ?i32 = null,

    /// The maximum number of messages that a campaign can send each second. For an
    /// application, this value specifies the default limit for the number of
    /// messages that campaigns can send each second. The minimum value is 1. The
    /// maximum value is 20,000.
    messages_per_second: ?i32 = null,

    /// The maximum total number of messages that the campaign can send per user
    /// session.
    session: ?i32 = null,

    /// The maximum number of messages that a campaign can send to a single endpoint
    /// during the course of the campaign. If a campaign recurs, this setting
    /// applies to all runs of the campaign. The maximum value is 100.
    total: ?i32 = null,

    pub const json_field_names = .{
        .daily = "Daily",
        .maximum_duration = "MaximumDuration",
        .messages_per_second = "MessagesPerSecond",
        .session = "Session",
        .total = "Total",
    };
};
