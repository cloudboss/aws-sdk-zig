/// Contains information about the filter used when retrieving metrics.
/// `MetricFiltersV2` can be used on
/// the following metrics: `AVG_AGENT_CONNECTING_TIME`, `CONTACTS_CREATED`,
/// `CONTACTS_HANDLED`, `SUM_CONTACTS_DISCONNECTED`.
pub const MetricFilterV2 = struct {
    /// The key to use for filtering data.
    ///
    /// Valid metric filter keys:
    ///
    /// * ANSWERING_MACHINE_DETECTION_STATUS
    ///
    /// * CASE_STATUS
    ///
    /// * DISCONNECT_REASON
    ///
    /// * FLOWS_ACTION_IDENTIFIER
    ///
    /// * FLOWS_NEXT_ACTION_IDENTIFIER
    ///
    /// * FLOWS_OUTCOME_TYPE
    ///
    /// * FLOWS_RESOURCE_TYPE
    ///
    /// * INITIATION_METHOD
    metric_filter_key: ?[]const u8,

    /// The values to use for filtering data. Values for metric-level filters can be
    /// either a fixed set of values or a
    /// customized list, depending on the use case.
    ///
    /// For valid values of metric-level filters `INITIATION_METHOD`,
    /// `DISCONNECT_REASON`, and
    /// `ANSWERING_MACHINE_DETECTION_STATUS`, see
    /// [ContactTraceRecord](https://docs.aws.amazon.com/connect/latest/adminguide/ctr-data-model.html#ctr-ContactTraceRecord) in the
    /// *Amazon Connect Administrator Guide*.
    ///
    /// For valid values of the metric-level filter `FLOWS_OUTCOME_TYPE`, see the
    /// description for the [Flow
    /// outcome](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#flows-outcome)
    /// metric in the *Amazon Connect Administrator Guide*.
    ///
    /// For valid values of the metric-level filter `BOT_CONVERSATION_OUTCOME_TYPE`,
    /// see the description for
    /// the [Bot conversations
    /// completed](https://docs.aws.amazon.com/connect/latest/adminguide/bot-metrics.html#bot-conversations-completed-metric) in the *Amazon Connect Administrator Guide*.
    ///
    /// For valid values of the metric-level filter `BOT_INTENT_OUTCOME_TYPE`, see
    /// the description for the
    /// [Bot
    /// intents
    /// completed](https://docs.aws.amazon.com/connect/latest/adminguide/bot-metrics.html#bot-intents-completed-metric) metric in the *Amazon Connect Administrator Guide*.
    metric_filter_values: ?[]const []const u8,

    /// If set to `true`, the API response contains results that filter out the
    /// results matched by the
    /// metric-level filters condition. By default, `Negate` is set to `false`.
    negate: bool = false,

    pub const json_field_names = .{
        .metric_filter_key = "MetricFilterKey",
        .metric_filter_values = "MetricFilterValues",
        .negate = "Negate",
    };
};
