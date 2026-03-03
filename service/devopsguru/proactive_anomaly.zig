const AnomalyReportedTimeRange = @import("anomaly_reported_time_range.zig").AnomalyReportedTimeRange;
const AnomalyResource = @import("anomaly_resource.zig").AnomalyResource;
const AnomalyTimeRange = @import("anomaly_time_range.zig").AnomalyTimeRange;
const PredictionTimeRange = @import("prediction_time_range.zig").PredictionTimeRange;
const ResourceCollection = @import("resource_collection.zig").ResourceCollection;
const AnomalySeverity = @import("anomaly_severity.zig").AnomalySeverity;
const AnomalySourceDetails = @import("anomaly_source_details.zig").AnomalySourceDetails;
const AnomalySourceMetadata = @import("anomaly_source_metadata.zig").AnomalySourceMetadata;
const AnomalyStatus = @import("anomaly_status.zig").AnomalyStatus;

/// Information about an anomaly. This object is returned by
/// `ListAnomalies`.
pub const ProactiveAnomaly = struct {
    /// An `AnomalyReportedTimeRange` object that specifies the time range between
    /// when the anomaly is opened and the time when it is closed.
    anomaly_reported_time_range: ?AnomalyReportedTimeRange = null,

    /// Information about a resource in which DevOps Guru detected anomalous
    /// behavior.
    anomaly_resources: ?[]const AnomalyResource = null,

    anomaly_time_range: ?AnomalyTimeRange = null,

    /// The ID of the insight that contains this anomaly. An insight is composed of
    /// related
    /// anomalies.
    associated_insight_id: ?[]const u8 = null,

    /// A description of the proactive anomaly.
    description: ?[]const u8 = null,

    /// The ID of a proactive anomaly.
    id: ?[]const u8 = null,

    /// A threshold that was exceeded by behavior in analyzed resources. Exceeding
    /// this
    /// threshold is related to the anomalous behavior that generated this anomaly.
    limit: ?f64 = null,

    prediction_time_range: ?PredictionTimeRange = null,

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

    /// The metadata for the anomaly.
    source_metadata: ?AnomalySourceMetadata = null,

    /// The status of a proactive anomaly.
    status: ?AnomalyStatus = null,

    /// The time of the anomaly's most recent update.
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .anomaly_reported_time_range = "AnomalyReportedTimeRange",
        .anomaly_resources = "AnomalyResources",
        .anomaly_time_range = "AnomalyTimeRange",
        .associated_insight_id = "AssociatedInsightId",
        .description = "Description",
        .id = "Id",
        .limit = "Limit",
        .prediction_time_range = "PredictionTimeRange",
        .resource_collection = "ResourceCollection",
        .severity = "Severity",
        .source_details = "SourceDetails",
        .source_metadata = "SourceMetadata",
        .status = "Status",
        .update_time = "UpdateTime",
    };
};
