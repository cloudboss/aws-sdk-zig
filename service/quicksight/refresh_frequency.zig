const RefreshInterval = @import("refresh_interval.zig").RefreshInterval;
const ScheduleRefreshOnEntity = @import("schedule_refresh_on_entity.zig").ScheduleRefreshOnEntity;

/// Specifies the interval between each scheduled refresh of a dataset.
pub const RefreshFrequency = struct {
    /// The interval between scheduled refreshes. Valid values are as follows:
    ///
    /// * `MINUTE15`: The dataset refreshes every 15 minutes. This value is only
    ///   supported for incremental refreshes. This interval can only be used for
    ///   one schedule per dataset.
    ///
    /// * `MINUTE30`:The dataset refreshes every 30 minutes. This value is only
    ///   supported for incremental refreshes. This interval can only be used for
    ///   one schedule per dataset.
    ///
    /// * `HOURLY`: The dataset refreshes every hour. This interval can only be used
    ///   for one schedule per dataset.
    ///
    /// * `DAILY`: The dataset refreshes every day.
    ///
    /// * `WEEKLY`: The dataset refreshes every week.
    ///
    /// * `MONTHLY`: The dataset refreshes every month.
    interval: RefreshInterval,

    /// The day of the week that you want to schedule the refresh on. This value is
    /// required for weekly and monthly refresh intervals.
    refresh_on_day: ?ScheduleRefreshOnEntity,

    /// The time of day that you want the datset to refresh. This value is expressed
    /// in HH:MM format. This field is not required for schedules that refresh
    /// hourly.
    time_of_the_day: ?[]const u8,

    /// The timezone that you want the refresh schedule to use. The timezone ID must
    /// match a corresponding ID found on `java.util.time.getAvailableIDs()`.
    timezone: ?[]const u8,

    pub const json_field_names = .{
        .interval = "Interval",
        .refresh_on_day = "RefreshOnDay",
        .time_of_the_day = "TimeOfTheDay",
        .timezone = "Timezone",
    };
};
