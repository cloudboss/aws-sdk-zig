const MetricResult = @import("metric_result.zig").MetricResult;
const MonitorDataSource = @import("monitor_data_source.zig").MonitorDataSource;
const PredictorEvent = @import("predictor_event.zig").PredictorEvent;

/// Describes the results of a monitor evaluation.
pub const PredictorMonitorEvaluation = struct {
    /// The status of the monitor evaluation. The state can be `SUCCESS` or
    /// `FAILURE`.
    evaluation_state: ?[]const u8 = null,

    /// The timestamp that indicates when the monitor evaluation was started.
    evaluation_time: ?i64 = null,

    /// Information about any errors that may have occurred during the monitor
    /// evaluation.
    message: ?[]const u8 = null,

    /// A list of metrics Forecast calculated when monitoring a predictor. You can
    /// compare the value for each metric in the list to the metric's value in the
    /// Baseline to see how your predictor's performance is changing.
    metric_results: ?[]const MetricResult = null,

    /// The Amazon Resource Name (ARN) of the monitor resource.
    monitor_arn: ?[]const u8 = null,

    /// The source of the data the monitor resource used during the evaluation.
    monitor_data_source: ?MonitorDataSource = null,

    /// The number of items considered during the evaluation.
    num_items_evaluated: ?i64 = null,

    /// Provides details about a predictor event, such as a retraining.
    predictor_event: ?PredictorEvent = null,

    /// The Amazon Resource Name (ARN) of the resource to monitor.
    resource_arn: ?[]const u8 = null,

    /// The timestamp that indicates the end of the window that is used for monitor
    /// evaluation.
    window_end_datetime: ?i64 = null,

    /// The timestamp that indicates the start of the window that is used for
    /// monitor evaluation.
    window_start_datetime: ?i64 = null,

    pub const json_field_names = .{
        .evaluation_state = "EvaluationState",
        .evaluation_time = "EvaluationTime",
        .message = "Message",
        .metric_results = "MetricResults",
        .monitor_arn = "MonitorArn",
        .monitor_data_source = "MonitorDataSource",
        .num_items_evaluated = "NumItemsEvaluated",
        .predictor_event = "PredictorEvent",
        .resource_arn = "ResourceArn",
        .window_end_datetime = "WindowEndDatetime",
        .window_start_datetime = "WindowStartDatetime",
    };
};
