const CampaignHook = @import("campaign_hook.zig").CampaignHook;
const ApplicationSettingsJourneyLimits = @import("application_settings_journey_limits.zig").ApplicationSettingsJourneyLimits;
const CampaignLimits = @import("campaign_limits.zig").CampaignLimits;
const QuietTime = @import("quiet_time.zig").QuietTime;

/// Provides information about an application, including the default settings
/// for an application.
pub const ApplicationSettingsResource = struct {
    /// The unique identifier for the application. This identifier is displayed as
    /// the **Project ID** on the Amazon Pinpoint console.
    application_id: []const u8,

    /// The settings for the AWS Lambda function to invoke by default as a code hook
    /// for campaigns in the application. You can use this hook to customize
    /// segments that are used by campaigns in the application.
    campaign_hook: ?CampaignHook = null,

    /// The default sending limits for journeys in the application. These limits
    /// apply to each journey for the application but can be overridden, on a per
    /// journey basis, with the JourneyLimits resource.
    journey_limits: ?ApplicationSettingsJourneyLimits = null,

    /// The date and time, in ISO 8601 format, when the application's settings were
    /// last modified.
    last_modified_date: ?[]const u8 = null,

    /// The default sending limits for campaigns in the application.
    limits: ?CampaignLimits = null,

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
    quiet_time: ?QuietTime = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .campaign_hook = "CampaignHook",
        .journey_limits = "JourneyLimits",
        .last_modified_date = "LastModifiedDate",
        .limits = "Limits",
        .quiet_time = "QuietTime",
    };
};
