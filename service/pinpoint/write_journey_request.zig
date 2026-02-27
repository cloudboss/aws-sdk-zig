const aws = @import("aws");

const Activity = @import("activity.zig").Activity;
const ClosedDays = @import("closed_days.zig").ClosedDays;
const JourneyChannelSettings = @import("journey_channel_settings.zig").JourneyChannelSettings;
const JourneyLimits = @import("journey_limits.zig").JourneyLimits;
const OpenHours = @import("open_hours.zig").OpenHours;
const QuietTime = @import("quiet_time.zig").QuietTime;
const JourneySchedule = @import("journey_schedule.zig").JourneySchedule;
const StartCondition = @import("start_condition.zig").StartCondition;
const State = @import("state.zig").State;
const __TimezoneEstimationMethodsElement = @import("timezone_estimation_methods_element.zig").__TimezoneEstimationMethodsElement;

/// Specifies the configuration and other settings for a journey.
pub const WriteJourneyRequest = struct {
    /// A map that contains a set of Activity objects, one object for each activity
    /// in the journey. For each Activity object, the key is the unique identifier
    /// (string) for an activity and the value is the settings for the activity. An
    /// activity identifier can contain a maximum of 100 characters. The characters
    /// must be alphanumeric characters.
    activities: ?[]const aws.map.MapEntry(Activity),

    /// The time when journey will stop sending messages. QuietTime should be
    /// configured first and SendingSchedule should be set to true.
    closed_days: ?ClosedDays,

    /// The date, in ISO 8601 format, when the journey was created.
    creation_date: ?[]const u8,

    /// The channel-specific configurations for the journey.
    journey_channel_settings: ?JourneyChannelSettings,

    /// The date, in ISO 8601 format, when the journey was last modified.
    last_modified_date: ?[]const u8,

    /// The messaging and entry limits for the journey.
    limits: ?JourneyLimits,

    /// Specifies whether the journey's scheduled start and end times use each
    /// participant's local time. To base the schedule on each participant's local
    /// time, set this value to true.
    local_time: ?bool,

    /// The name of the journey. A journey name can contain a maximum of 150
    /// characters. The characters can be alphanumeric characters or symbols, such
    /// as underscores (_) or hyphens (-). A journey name can't contain any spaces.
    name: []const u8,

    /// The time when journey allow to send messages. QuietTime should be configured
    /// first and SendingSchedule should be set to true.
    open_hours: ?OpenHours,

    /// The quiet time settings for the journey. Quiet time is a specific time range
    /// when a journey doesn't send messages to participants, if all the following
    /// conditions are met:
    ///
    /// * The EndpointDemographic.Timezone property of the endpoint for the
    ///   participant is set to a valid value.
    /// * The current time in the participant's time zone is later than or equal to
    ///   the time specified by the QuietTime.Start property for the journey.
    /// * The current time in the participant's time zone is earlier than or equal
    ///   to the time specified by the QuietTime.End property for the journey.
    ///
    /// If any of the preceding conditions isn't met, the participant will receive
    /// messages from the journey, even if quiet time is enabled.
    quiet_time: ?QuietTime,

    /// The frequency with which Amazon Pinpoint evaluates segment and event data
    /// for the journey, as a duration in ISO 8601 format.
    refresh_frequency: ?[]const u8,

    /// Indicates whether the journey participants should be refreshed when a
    /// segment is updated.
    refresh_on_segment_update: ?bool,

    /// The schedule settings for the journey.
    schedule: ?JourneySchedule,

    /// Indicates if journey has Advance Quiet Time enabled. This flag should be set
    /// to true in order to allow using OpenHours and ClosedDays.
    sending_schedule: ?bool,

    /// The unique identifier for the first activity in the journey. The identifier
    /// for this activity can contain a maximum of 128 characters. The characters
    /// must be alphanumeric characters.
    start_activity: ?[]const u8,

    /// The segment that defines which users are participants in the journey.
    start_condition: ?StartCondition,

    /// The status of the journey. Valid values are:
    ///
    /// * DRAFT - Saves the journey and doesn't publish it.
    /// * ACTIVE - Saves and publishes the journey. Depending on the journey's
    ///   schedule, the journey starts running immediately or at the scheduled start
    ///   time. If a journey's status is ACTIVE, you can't add, change, or remove
    ///   activities from it.
    ///
    /// PAUSED, CANCELLED, COMPLETED, and CLOSED states are not supported in
    /// requests to create or update a journey. To cancel, pause, or resume a
    /// journey, use the Journey State resource.
    state: ?State,

    /// An array of time zone estimation methods, if any, to use for determining an
    /// [Endpoints](https://docs.aws.amazon.com/pinpoint/latest/apireference/apps-application-id-endpoints-endpoint-id.html) time zone if the Endpoint does not have a value for the Demographic.Timezone attribute.
    ///
    /// * PHONE_NUMBER - A time zone is determined based on the Endpoint.Address and
    ///   Endpoint.Location.Country.
    /// * POSTAL_CODE - A time zone is determined based on the
    ///   Endpoint.Location.PostalCode and Endpoint.Location.Country.
    ///
    /// POSTAL_CODE detection is only supported in the United States, United
    /// Kingdom, Australia, New Zealand, Canada, France, Italy, Spain, Germany and
    /// in regions where Amazon Pinpoint is available.
    timezone_estimation_methods: ?[]const __TimezoneEstimationMethodsElement,

    /// Specifies whether endpoints in quiet hours should enter a wait till the end
    /// of their quiet hours.
    wait_for_quiet_time: ?bool,

    pub const json_field_names = .{
        .activities = "Activities",
        .closed_days = "ClosedDays",
        .creation_date = "CreationDate",
        .journey_channel_settings = "JourneyChannelSettings",
        .last_modified_date = "LastModifiedDate",
        .limits = "Limits",
        .local_time = "LocalTime",
        .name = "Name",
        .open_hours = "OpenHours",
        .quiet_time = "QuietTime",
        .refresh_frequency = "RefreshFrequency",
        .refresh_on_segment_update = "RefreshOnSegmentUpdate",
        .schedule = "Schedule",
        .sending_schedule = "SendingSchedule",
        .start_activity = "StartActivity",
        .start_condition = "StartCondition",
        .state = "State",
        .timezone_estimation_methods = "TimezoneEstimationMethods",
        .wait_for_quiet_time = "WaitForQuietTime",
    };
};
