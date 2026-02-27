const HistoricalMetricName = @import("historical_metric_name.zig").HistoricalMetricName;
const Statistic = @import("statistic.zig").Statistic;
const Threshold = @import("threshold.zig").Threshold;
const Unit = @import("unit.zig").Unit;

/// Contains information about a historical metric.
pub const HistoricalMetric = struct {
    /// The name of the metric. Following is a list of each supported metric mapped
    /// to the UI name, linked to a detailed
    /// description in the *Amazon Connect Administrator Guide*.
    ///
    /// **ABANDON_TIME**
    ///
    /// Unit: SECONDS
    ///
    /// Statistic: AVG
    ///
    /// UI name: [Average queue abandon
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-queue-abandon-time)
    ///
    /// **AFTER_CONTACT_WORK_TIME**
    ///
    /// Unit: SECONDS
    ///
    /// Statistic: AVG
    ///
    /// UI name: [After contact work
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#after-contact-work-time)
    ///
    /// **API_CONTACTS_HANDLED**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [API contacts
    /// handled](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#api-contacts-handled)
    ///
    /// **AVG_HOLD_TIME**
    ///
    /// Unit: SECONDS
    ///
    /// Statistic: AVG
    ///
    /// UI name: [Average customer hold
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-customer-hold-time)
    ///
    /// **CALLBACK_CONTACTS_HANDLED**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Callback contacts
    /// handled](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#callback-contacts-handled)
    ///
    /// **CONTACTS_ABANDONED**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Contacts
    /// abandoned](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-abandoned)
    ///
    /// **CONTACTS_AGENT_HUNG_UP_FIRST**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Contacts agent hung up
    /// first](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-agent-hung-up-first)
    ///
    /// **CONTACTS_CONSULTED**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Contacts
    /// consulted](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-consulted)
    ///
    /// **CONTACTS_HANDLED**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Contacts
    /// handled](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-handled)
    ///
    /// **CONTACTS_HANDLED_INCOMING**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Contacts handled
    /// incoming](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-handled-incoming)
    ///
    /// **CONTACTS_HANDLED_OUTBOUND**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Contacts handled
    /// outbound](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-handled-outbound)
    ///
    /// **CONTACTS_HOLD_ABANDONS**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Contacts hold
    /// disconnect](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-hold-disconnect)
    ///
    /// **CONTACTS_MISSED**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name:
    /// [AGENT_NON_RESPONSE](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#agent-non-response)
    ///
    /// **CONTACTS_QUEUED**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Contacts
    /// queued](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-queued)
    ///
    /// **CONTACTS_TRANSFERRED_IN**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Contacts transferred
    /// in](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-transferred-in)
    ///
    /// **CONTACTS_TRANSFERRED_IN_FROM_QUEUE**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Contacts transferred out
    /// queue](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-transferred-out-queue)
    ///
    /// **CONTACTS_TRANSFERRED_OUT**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Contacts transferred
    /// out](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-transferred-out)
    ///
    /// **CONTACTS_TRANSFERRED_OUT_FROM_QUEUE**
    ///
    /// Unit: COUNT
    ///
    /// Statistic: SUM
    ///
    /// UI name: [Contacts transferred out
    /// queue](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-transferred-out-queue)
    ///
    /// **HANDLE_TIME**
    ///
    /// Unit: SECONDS
    ///
    /// Statistic: AVG
    ///
    /// UI name: [Average handle
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-handle-time)
    ///
    /// **INTERACTION_AND_HOLD_TIME**
    ///
    /// Unit: SECONDS
    ///
    /// Statistic: AVG
    ///
    /// UI name: [Average
    /// agent interaction and customer hold
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-interaction-and-customer-hold-time)
    ///
    /// **INTERACTION_TIME**
    ///
    /// Unit: SECONDS
    ///
    /// Statistic: AVG
    ///
    /// UI name: [Average agent
    /// interaction
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#aaverage-agent-interaction-time)
    ///
    /// **OCCUPANCY**
    ///
    /// Unit: PERCENT
    ///
    /// Statistic: AVG
    ///
    /// UI name:
    /// [Occupancy](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#occupancy)
    ///
    /// **QUEUE_ANSWER_TIME**
    ///
    /// Unit: SECONDS
    ///
    /// Statistic: AVG
    ///
    /// UI name: [Average queue answer
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html##average-queue-answer-time)
    ///
    /// **QUEUED_TIME**
    ///
    /// Unit: SECONDS
    ///
    /// Statistic: MAX
    ///
    /// UI name: [Minimum flow
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#minimum-flow-time)
    ///
    /// **SERVICE_LEVEL**
    ///
    /// You can include up to 20 SERVICE_LEVEL metrics in a request.
    ///
    /// Unit: PERCENT
    ///
    /// Statistic: AVG
    ///
    /// Threshold: For `ThresholdValue`, enter any whole number from 1 to 604800
    /// (inclusive), in seconds.
    /// For `Comparison`, you must enter `LT` (for "Less than").
    ///
    /// UI name: [Service level
    /// X](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#service-level)
    name: ?HistoricalMetricName,

    /// The statistic for the metric.
    statistic: ?Statistic,

    /// The threshold for the metric, used with service level metrics.
    threshold: ?Threshold,

    /// The unit for the metric.
    unit: ?Unit,

    pub const json_field_names = .{
        .name = "Name",
        .statistic = "Statistic",
        .threshold = "Threshold",
        .unit = "Unit",
    };
};
