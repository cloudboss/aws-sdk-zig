const aws = @import("aws");

const TrafficShapingRetrievalWindow = @import("traffic_shaping_retrieval_window.zig").TrafficShapingRetrievalWindow;
const TrafficShapingTpsConfiguration = @import("traffic_shaping_tps_configuration.zig").TrafficShapingTpsConfiguration;
const TrafficShapingType = @import("traffic_shaping_type.zig").TrafficShapingType;

/// With recurring prefetch, MediaTailor automatically prefetches ads for every
/// avail that occurs during the retrieval window. The following configurations
/// describe the MediaTailor behavior when prefetching ads for a live event.
pub const RecurringRetrieval = struct {
    /// The number of seconds that MediaTailor waits after an ad avail before
    /// prefetching ads for the next avail. If not set, the default is 0 (no delay).
    delay_after_avail_end_seconds: ?i32 = null,

    /// The dynamic variables to use for substitution during prefetch requests to
    /// the ADS.
    dynamic_variables: ?[]const aws.map.StringMapEntry = null,

    /// The configuration that tells Elemental MediaTailor how many seconds to
    /// spread out requests to the ad decision server (ADS). Instead of sending ADS
    /// requests for all sessions at the same time, MediaTailor spreads the requests
    /// across the amount of time specified in the retrieval window.
    traffic_shaping_retrieval_window: ?TrafficShapingRetrievalWindow = null,

    /// The configuration for TPS-based traffic shaping. This approach limits
    /// requests to the ad decision server (ADS) based on transactions per second
    /// and concurrent users.
    traffic_shaping_tps_configuration: ?TrafficShapingTpsConfiguration = null,

    /// Indicates the type of traffic shaping used to limit the number of requests
    /// to the ADS at one time.
    traffic_shaping_type: ?TrafficShapingType = null,

    pub const json_field_names = .{
        .delay_after_avail_end_seconds = "DelayAfterAvailEndSeconds",
        .dynamic_variables = "DynamicVariables",
        .traffic_shaping_retrieval_window = "TrafficShapingRetrievalWindow",
        .traffic_shaping_tps_configuration = "TrafficShapingTpsConfiguration",
        .traffic_shaping_type = "TrafficShapingType",
    };
};
