const aws = @import("aws");

const TrafficShapingRetrievalWindow = @import("traffic_shaping_retrieval_window.zig").TrafficShapingRetrievalWindow;
const TrafficShapingTpsConfiguration = @import("traffic_shaping_tps_configuration.zig").TrafficShapingTpsConfiguration;
const TrafficShapingType = @import("traffic_shaping_type.zig").TrafficShapingType;

/// A complex type that contains settings governing when MediaTailor prefetches
/// ads, and which dynamic variables that MediaTailor includes in the request to
/// the ad decision server.
pub const PrefetchRetrieval = struct {
    /// The dynamic variables to use for substitution during prefetch requests to
    /// the ad decision server (ADS).
    ///
    /// You initially configure [dynamic
    /// variables](https://docs.aws.amazon.com/mediatailor/latest/ug/variables.html)
    /// for the ADS URL when you set up your playback configuration. When you
    /// specify `DynamicVariables` for prefetch retrieval, MediaTailor includes the
    /// dynamic variables in the request to the ADS.
    dynamic_variables: ?[]const aws.map.StringMapEntry = null,

    /// The time when prefetch retrieval ends for the ad break. Prefetching will be
    /// attempted for manifest requests that occur at or before this time.
    end_time: i64,

    /// The time when prefetch retrievals can start for this break. Ad prefetching
    /// will be attempted for manifest requests that occur at or after this time.
    /// Defaults to the current time. If not specified, the prefetch retrieval
    /// starts as soon as possible.
    start_time: ?i64 = null,

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
        .dynamic_variables = "DynamicVariables",
        .end_time = "EndTime",
        .start_time = "StartTime",
        .traffic_shaping_retrieval_window = "TrafficShapingRetrievalWindow",
        .traffic_shaping_tps_configuration = "TrafficShapingTpsConfiguration",
        .traffic_shaping_type = "TrafficShapingType",
    };
};
