const PrefetchConsumption = @import("prefetch_consumption.zig").PrefetchConsumption;
const RecurringPrefetchConfiguration = @import("recurring_prefetch_configuration.zig").RecurringPrefetchConfiguration;
const PrefetchRetrieval = @import("prefetch_retrieval.zig").PrefetchRetrieval;
const PrefetchScheduleType = @import("prefetch_schedule_type.zig").PrefetchScheduleType;

/// A prefetch schedule allows you to tell MediaTailor to fetch and prepare
/// certain ads before an ad break happens. For more information about ad
/// prefetching, see [Using ad
/// prefetching](https://docs.aws.amazon.com/mediatailor/latest/ug/prefetching-ads.html) in the *MediaTailor User Guide*.
pub const PrefetchSchedule = struct {
    /// The Amazon Resource Name (ARN) of the prefetch schedule.
    arn: []const u8,

    /// Consumption settings determine how, and when, MediaTailor places the
    /// prefetched ads into ad breaks for single prefetch schedules. Ad consumption
    /// occurs within a span of time that you define, called a *consumption window*.
    /// You can designate which ad breaks that MediaTailor fills with prefetch ads
    /// by setting avail matching criteria.
    consumption: ?PrefetchConsumption = null,

    /// The name of the prefetch schedule. The name must be unique among all
    /// prefetch schedules that are associated with the specified playback
    /// configuration.
    name: []const u8,

    /// The name of the playback configuration to create the prefetch schedule for.
    playback_configuration_name: []const u8,

    /// The settings that determine how and when MediaTailor prefetches ads and
    /// inserts them into ad breaks.
    recurring_prefetch_configuration: ?RecurringPrefetchConfiguration = null,

    /// A complex type that contains settings for prefetch retrieval from the ad
    /// decision server (ADS).
    retrieval: ?PrefetchRetrieval = null,

    /// The frequency that MediaTailor creates prefetch schedules. `SINGLE`
    /// indicates that this schedule applies to one ad break. `RECURRING` indicates
    /// that MediaTailor automatically creates a schedule for each ad avail in a
    /// live event.
    ///
    /// For more information about the prefetch types and when you might use each,
    /// see [Prefetching ads in Elemental
    /// MediaTailor.](https://docs.aws.amazon.com/mediatailor/latest/ug/prefetching-ads.html)
    schedule_type: ?PrefetchScheduleType = null,

    /// An optional stream identifier that you can specify in order to prefetch for
    /// multiple streams that use the same playback configuration.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .consumption = "Consumption",
        .name = "Name",
        .playback_configuration_name = "PlaybackConfigurationName",
        .recurring_prefetch_configuration = "RecurringPrefetchConfiguration",
        .retrieval = "Retrieval",
        .schedule_type = "ScheduleType",
        .stream_id = "StreamId",
    };
};
