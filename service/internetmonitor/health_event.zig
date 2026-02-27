const ImpactedLocation = @import("impacted_location.zig").ImpactedLocation;
const HealthEventImpactType = @import("health_event_impact_type.zig").HealthEventImpactType;
const HealthEventStatus = @import("health_event_status.zig").HealthEventStatus;

/// Information about a health event created in a monitor in Amazon CloudWatch
/// Internet Monitor.
pub const HealthEvent = struct {
    /// When the health event was created.
    created_at: ?i64,

    /// The time when a health event ended. If the health event is still active,
    /// then the end time is not set.
    ended_at: ?i64,

    /// The Amazon Resource Name (ARN) of the event.
    event_arn: []const u8,

    /// The internally-generated identifier of a specific network traffic impairment
    /// health event.
    event_id: []const u8,

    /// The value of the threshold percentage for performance or availability that
    /// was configured when Amazon CloudWatch Internet Monitor created the health
    /// event.
    health_score_threshold: f64 = 0,

    /// The locations impacted by the health event.
    impacted_locations: []const ImpactedLocation,

    /// The type of impairment for a health event.
    impact_type: HealthEventImpactType,

    /// When the health event was last updated.
    last_updated_at: i64,

    /// The impact on total traffic that a health event has, in increased latency or
    /// reduced availability. This is the
    /// percentage of how much latency has increased or availability has decreased
    /// during the event, compared to what is typical for traffic from this
    /// client location to the Amazon Web Services location using this client
    /// network.
    percent_of_total_traffic_impacted: ?f64,

    /// When a health event started.
    started_at: i64,

    /// The status of a health event.
    status: HealthEventStatus,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .ended_at = "EndedAt",
        .event_arn = "EventArn",
        .event_id = "EventId",
        .health_score_threshold = "HealthScoreThreshold",
        .impacted_locations = "ImpactedLocations",
        .impact_type = "ImpactType",
        .last_updated_at = "LastUpdatedAt",
        .percent_of_total_traffic_impacted = "PercentOfTotalTrafficImpacted",
        .started_at = "StartedAt",
        .status = "Status",
    };
};
