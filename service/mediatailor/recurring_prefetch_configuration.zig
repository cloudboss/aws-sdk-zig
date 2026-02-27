const RecurringConsumption = @import("recurring_consumption.zig").RecurringConsumption;
const RecurringRetrieval = @import("recurring_retrieval.zig").RecurringRetrieval;

/// The configuration that defines how MediaTailor performs recurring prefetch.
pub const RecurringPrefetchConfiguration = struct {
    /// The end time for the window that MediaTailor prefetches and inserts ads in a
    /// live event.
    end_time: i64,

    /// The settings that determine how and when MediaTailor places prefetched ads
    /// into upcoming ad breaks for recurring prefetch scedules.
    recurring_consumption: RecurringConsumption,

    /// The configuration for prefetch ad retrieval from the ADS.
    recurring_retrieval: RecurringRetrieval,

    /// The start time for the window that MediaTailor prefetches and inserts ads in
    /// a live event.
    start_time: ?i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .recurring_consumption = "RecurringConsumption",
        .recurring_retrieval = "RecurringRetrieval",
        .start_time = "StartTime",
    };
};
