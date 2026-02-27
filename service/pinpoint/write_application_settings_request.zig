const CampaignHook = @import("campaign_hook.zig").CampaignHook;
const ApplicationSettingsJourneyLimits = @import("application_settings_journey_limits.zig").ApplicationSettingsJourneyLimits;
const CampaignLimits = @import("campaign_limits.zig").CampaignLimits;
const QuietTime = @import("quiet_time.zig").QuietTime;

/// Specifies the default settings for an application.
pub const WriteApplicationSettingsRequest = struct {
    /// The settings for the AWS Lambda function to invoke by default as a code hook
    /// for campaigns in the application. You can use this hook to customize
    /// segments that are used by campaigns in the application.
    ///
    /// To override these settings and define custom settings for a specific
    /// campaign, use the CampaignHook object of the Campaign resource.
    campaign_hook: ?CampaignHook,

    /// Specifies whether to enable application-related alarms in Amazon CloudWatch.
    cloud_watch_metrics_enabled: ?bool,

    event_tagging_enabled: ?bool,

    /// The default sending limits for journeys in the application. These limits
    /// apply to each journey for the application but can be overridden, on a per
    /// journey basis, with the JourneyLimits resource.
    journey_limits: ?ApplicationSettingsJourneyLimits,

    /// The default sending limits for campaigns in the application. To override
    /// these limits and define custom limits for a specific campaign or journey,
    /// use the Campaign resource or the Journey resource, respectively.
    limits: ?CampaignLimits,

    /// The default quiet time for campaigns in the application. Quiet time is a
    /// specific time range when messages aren't sent to endpoints, if all the
    /// following conditions are met:
    ///
    /// * The EndpointDemographic.Timezone property of the endpoint is set to a
    ///   valid value.
    /// * The current time in the endpoint's time zone is later than or equal to the
    ///   time specified by the QuietTime.Start property for the application (or a
    ///   campaign or journey that has custom quiet time settings).
    /// * The current time in the endpoint's time zone is earlier than or equal to
    ///   the time specified by the QuietTime.End property for the application (or a
    ///   campaign or journey that has custom quiet time settings).
    ///
    /// If any of the preceding conditions isn't met, the endpoint will receive
    /// messages from a campaign or journey, even if quiet time is enabled.
    ///
    /// To override the default quiet time settings for a specific campaign or
    /// journey, use the Campaign resource or the Journey resource to define a
    /// custom quiet time for the campaign or journey.
    quiet_time: ?QuietTime,

    pub const json_field_names = .{
        .campaign_hook = "CampaignHook",
        .cloud_watch_metrics_enabled = "CloudWatchMetricsEnabled",
        .event_tagging_enabled = "EventTaggingEnabled",
        .journey_limits = "JourneyLimits",
        .limits = "Limits",
        .quiet_time = "QuietTime",
    };
};
