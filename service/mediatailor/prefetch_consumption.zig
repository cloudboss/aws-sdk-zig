const AvailMatchingCriteria = @import("avail_matching_criteria.zig").AvailMatchingCriteria;

/// For single prefetch, describes how and when that MediaTailor places
/// prefetched ads into upcoming ad breaks.
pub const PrefetchConsumption = struct {
    /// If you only want MediaTailor to insert prefetched ads into avails (ad
    /// breaks) that match specific dynamic variables, such as `scte.event_id`, set
    /// the avail matching criteria.
    avail_matching_criteria: ?[]const AvailMatchingCriteria,

    /// The time when MediaTailor no longer considers the prefetched ads for use in
    /// an ad break. MediaTailor automatically deletes prefetch schedules no less
    /// than seven days after the end time. If you'd like to manually delete the
    /// prefetch schedule, you can call `DeletePrefetchSchedule`.
    end_time: i64,

    /// The time when prefetched ads are considered for use in an ad break. If you
    /// don't specify `StartTime`, the prefetched ads are available after
    /// MediaTailor retrieves them from the ad decision server.
    start_time: ?i64,

    pub const json_field_names = .{
        .avail_matching_criteria = "AvailMatchingCriteria",
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
