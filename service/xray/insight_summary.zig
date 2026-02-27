const InsightCategory = @import("insight_category.zig").InsightCategory;
const RequestImpactStatistics = @import("request_impact_statistics.zig").RequestImpactStatistics;
const ServiceId = @import("service_id.zig").ServiceId;
const InsightState = @import("insight_state.zig").InsightState;
const AnomalousService = @import("anomalous_service.zig").AnomalousService;

/// Information that describes an insight.
pub const InsightSummary = struct {
    /// Categories The categories that label and describe the type of insight.
    categories: ?[]const InsightCategory,

    /// The impact statistics of the client side service. This includes the number
    /// of requests
    /// to the client service and whether the requests were faults or okay.
    client_request_impact_statistics: ?RequestImpactStatistics,

    /// The time, in Unix seconds, at which the insight ended.
    end_time: ?i64,

    /// The Amazon Resource Name (ARN) of the group that the insight belongs to.
    group_arn: ?[]const u8,

    /// The name of the group that the insight belongs to.
    group_name: ?[]const u8,

    /// The insights unique identifier.
    insight_id: ?[]const u8,

    /// The time, in Unix seconds, that the insight was last updated.
    last_update_time: ?i64,

    root_cause_service_id: ?ServiceId,

    /// The impact statistics of the root cause service. This includes the number of
    /// requests to
    /// the client service and whether the requests were faults or okay.
    root_cause_service_request_impact_statistics: ?RequestImpactStatistics,

    /// The time, in Unix seconds, at which the insight began.
    start_time: ?i64,

    /// The current state of the insight.
    state: ?InsightState,

    /// A brief description of the insight.
    summary: ?[]const u8,

    /// The service within the insight that is most impacted by the incident.
    top_anomalous_services: ?[]const AnomalousService,

    pub const json_field_names = .{
        .categories = "Categories",
        .client_request_impact_statistics = "ClientRequestImpactStatistics",
        .end_time = "EndTime",
        .group_arn = "GroupARN",
        .group_name = "GroupName",
        .insight_id = "InsightId",
        .last_update_time = "LastUpdateTime",
        .root_cause_service_id = "RootCauseServiceId",
        .root_cause_service_request_impact_statistics = "RootCauseServiceRequestImpactStatistics",
        .start_time = "StartTime",
        .state = "State",
        .summary = "Summary",
        .top_anomalous_services = "TopAnomalousServices",
    };
};
