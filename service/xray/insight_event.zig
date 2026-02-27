const RequestImpactStatistics = @import("request_impact_statistics.zig").RequestImpactStatistics;
const AnomalousService = @import("anomalous_service.zig").AnomalousService;

/// X-Ray reevaluates insights periodically until they are resolved, and records
/// each intermediate state in an
/// event. You can review incident events in the Impact Timeline on the Inspect
/// page in the X-Ray console.
pub const InsightEvent = struct {
    /// The impact statistics of the client side service. This includes the number
    /// of requests to the client service
    /// and whether the requests were faults or okay.
    client_request_impact_statistics: ?RequestImpactStatistics,

    /// The time, in Unix seconds, at which the event was recorded.
    event_time: ?i64,

    /// The impact statistics of the root cause service. This includes the number of
    /// requests to the client service
    /// and whether the requests were faults or okay.
    root_cause_service_request_impact_statistics: ?RequestImpactStatistics,

    /// A brief description of the event.
    summary: ?[]const u8,

    /// The service during the event that is most impacted by the incident.
    top_anomalous_services: ?[]const AnomalousService,

    pub const json_field_names = .{
        .client_request_impact_statistics = "ClientRequestImpactStatistics",
        .event_time = "EventTime",
        .root_cause_service_request_impact_statistics = "RootCauseServiceRequestImpactStatistics",
        .summary = "Summary",
        .top_anomalous_services = "TopAnomalousServices",
    };
};
