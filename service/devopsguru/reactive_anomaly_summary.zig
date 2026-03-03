const AnomalyReportedTimeRange = @import("anomaly_reported_time_range.zig").AnomalyReportedTimeRange;
const AnomalyResource = @import("anomaly_resource.zig").AnomalyResource;
const AnomalyTimeRange = @import("anomaly_time_range.zig").AnomalyTimeRange;
const ResourceCollection = @import("resource_collection.zig").ResourceCollection;
const AnomalySeverity = @import("anomaly_severity.zig").AnomalySeverity;
const AnomalySourceDetails = @import("anomaly_source_details.zig").AnomalySourceDetails;
const AnomalyStatus = @import("anomaly_status.zig").AnomalyStatus;
const AnomalyType = @import("anomaly_type.zig").AnomalyType;

/// Details about a reactive anomaly. This object is returned by
/// `DescribeAnomaly.`
pub const ReactiveAnomalySummary = struct {
    /// An `AnomalyReportedTimeRange` object that specifies the time range between
    /// when the anomaly is opened and the time when it is closed.
    anomaly_reported_time_range: ?AnomalyReportedTimeRange = null,

    /// The Amazon Web Services resources in which anomalous behavior was detected
    /// by DevOps Guru.
    anomaly_resources: ?[]const AnomalyResource = null,

    anomaly_time_range: ?AnomalyTimeRange = null,

    /// The ID of the insight that contains this anomaly. An insight is composed of
    /// related
    /// anomalies.
    associated_insight_id: ?[]const u8 = null,

    /// The ID of the causal anomaly that is associated with this
    /// reactive anomaly. The ID of a `CAUSAL` anomaly is always `NULL`.
    causal_anomaly_id: ?[]const u8 = null,

    /// A description of the reactive anomaly.
    description: ?[]const u8 = null,

    /// The ID of the reactive anomaly.
    id: ?[]const u8 = null,

    /// The name of the reactive anomaly.
    name: ?[]const u8 = null,

    resource_collection: ?ResourceCollection = null,

    /// The severity of the anomaly. The severity of anomalies that generate
    /// an insight determine that insight's severity. For more information, see
    /// [Understanding
    /// insight
    /// severities](https://docs.aws.amazon.com/devops-guru/latest/userguide/working-with-insights.html#understanding-insights-severities) in the *Amazon DevOps Guru User Guide*.
    severity: ?AnomalySeverity = null,

    /// Details about the source of the analyzed operational data that triggered the
    /// anomaly.
    /// The one supported source is Amazon CloudWatch metrics.
    source_details: ?AnomalySourceDetails = null,

    /// The status of the reactive anomaly.
    status: ?AnomalyStatus = null,

    /// The type of the reactive anomaly. It can be one of the following types.
    ///
    /// * `CAUSAL` - the anomaly can cause a new insight.
    ///
    /// * `CONTEXTUAL` - the anomaly contains additional information about an
    ///   insight or its causal anomaly.
    @"type": ?AnomalyType = null,

    pub const json_field_names = .{
        .anomaly_reported_time_range = "AnomalyReportedTimeRange",
        .anomaly_resources = "AnomalyResources",
        .anomaly_time_range = "AnomalyTimeRange",
        .associated_insight_id = "AssociatedInsightId",
        .causal_anomaly_id = "CausalAnomalyId",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .resource_collection = "ResourceCollection",
        .severity = "Severity",
        .source_details = "SourceDetails",
        .status = "Status",
        .@"type" = "Type",
    };
};
