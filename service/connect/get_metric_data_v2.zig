const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FilterV2 = @import("filter_v2.zig").FilterV2;
const IntervalDetails = @import("interval_details.zig").IntervalDetails;
const MetricV2 = @import("metric_v2.zig").MetricV2;
const MetricResultV2 = @import("metric_result_v2.zig").MetricResultV2;

pub const GetMetricDataV2Input = struct {
    /// The timestamp, in UNIX Epoch time format, at which to end the reporting
    /// interval for the retrieval of historical
    /// metrics data. The time must be later than the start time timestamp. It
    /// cannot be later than the current
    /// timestamp.
    end_time: i64,

    /// The filters to apply to returned metrics. You can filter on the following
    /// resources:
    ///
    /// * Agents
    ///
    /// * Campaigns
    ///
    /// * Channels
    ///
    /// * Feature
    ///
    /// * Queues
    ///
    /// * Routing profiles
    ///
    /// * Routing step expression
    ///
    /// * User hierarchy groups
    ///
    /// At least one filter must be passed from queues, routing profiles, agents, or
    /// user hierarchy groups.
    ///
    /// For metrics for outbound campaigns analytics, you can also use campaigns to
    /// satisfy at least one filter
    /// requirement.
    ///
    /// To filter by phone number, see [Create a historical metrics
    /// report](https://docs.aws.amazon.com/connect/latest/adminguide/create-historical-metrics-report.html) in
    /// the *Amazon Connect Administrator Guide*.
    ///
    /// Note the following limits:
    ///
    /// * **Filter keys**: A maximum of 5 filter keys are supported in a single
    ///   request.
    /// Valid filter keys: `AGENT` | `AGENT_HIERARCHY_LEVEL_FIVE` |
    /// `AGENT_HIERARCHY_LEVEL_FOUR` | `AGENT_ HIERARCHY_LEVEL_ONE` |
    /// `AGENT_HIERARCHY_LEVEL_THREE` | `AGENT_HIERARCHY_LEVEL_TWO` | `
    /// ANSWERING_MACHINE_DETECTION_STATUS` | `BOT_ALIAS` | `BOT_ID` |
    /// `BOT_INTENT_NAME` | `BOT_LOCALE` | `BOT_VERSION` | `CAMPAIGN` |
    /// `CAMPAIGN_DELIVERY_EVENT_TYPE` | ` CAMPAIGN_EXCLUDED_EVENT_TYPE` |
    /// `CASE_STATUS`
    /// | `CASE_TEMPLATE_ARN` | `CHANNEL` | `
    /// contact/segmentAttributes/connect:Subtype` |
    /// `contact/segmentAttributes/connect:ValidationTestType` | `
    /// DISCONNECT_REASON` |
    /// `EVALUATION_FORM` | `EVALUATION_QUESTION` | `EVALUATION_SECTION` |
    /// `EVALUATION_SOURCE` | `EVALUATOR_ID` | `FEATURE` | `FLOW_ACTION_ID` |
    /// `FLOW_TYPE` | `FLOWS_MODULE_RESOURCE_ID` | `FLOWS_NEXT_RESOURCE_ID` |
    /// `FLOWS_NEXT_RESOURCE_QUEUE_ID` | `FLOWS_OUTCOME_TYPE` | `FLOWS_RESOURCE_ID`
    /// |
    /// `FORM_VERSION` | `INITIATING_FLOW` | `INITIATION_METHOD` |
    /// `INVOKING_RESOURCE_PUBLISHED_TIMESTAMP` | `INVOKING_RESOURCE_TYPE` |
    /// `PARENT_FLOWS_RESOURCE_ID` | `Q_CONNECT_ENABLED` | `QUEUE` |
    /// `RESOURCE_PUBLISHED_ TIMESTAMP` | `ROUTING_PROFILE` |
    /// `ROUTING_STEP_EXPRESSION` |
    /// `TEST_CASE` | `TEST_ CASE_EXECUTION_FAILURE_REASON` |
    /// `TEST_CASE_EXECUTION_RESULT` | `TEST_CASE_EXECUTION_STATE`
    ///
    /// * **Filter values**: A maximum of 100 filter values are supported in a
    ///   single
    /// request. VOICE, CHAT, and TASK are valid `filterValue` for the CHANNEL
    /// filter key. They do not count
    /// towards limitation of 100 filter values. For example, a GetMetricDataV2
    /// request can filter by 50 queues, 35 agents,
    /// and 15 routing profiles for a total of 100 filter values, along with 3
    /// channel filters.
    ///
    /// `contact_lens_conversational_analytics` is a valid filterValue for the
    /// `FEATURE` filter
    /// key. It is available only to contacts analyzed by Contact Lens
    /// conversational analytics.
    ///
    /// `connect:Chat`, `connect:SMS`, `connect:Telephony`, and
    /// `connect:WebRTC` are valid `filterValue` examples (not exhaustive) for the
    /// `contact/segmentAttributes/connect:Subtype filter` key.
    ///
    /// `ROUTING_STEP_EXPRESSION` is a valid filter key with a filter value up to
    /// 3000 length. This filter
    /// is case and order sensitive. JSON string fields must be sorted in ascending
    /// order and JSON array order should be
    /// kept as is.
    ///
    /// `Q_CONNECT_ENABLED`. TRUE and FALSE are the only valid filterValues for the
    /// `Q_CONNECT_ENABLED` filter key.
    ///
    /// * TRUE includes all contacts that had Connect AI Agents enabled as part of
    ///   the flow.
    ///
    /// * FALSE includes all contacts that did not have Connect AI Agents enabled as
    ///   part of the flow
    ///
    /// * EXPERIENCE_VALIDATION and FLOW_VALIDATION are the only valid filterValues
    ///   for the
    /// contact/segmentAttributes/connect:ValidationTestType filter key
    ///
    /// This filter is available only for contact record-driven metrics.
    ///
    /// [Campaign](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-outbound-campaigns_Campaign.html) ARNs are valid `filterValues` for the `CAMPAIGN` filter key.
    filters: []const FilterV2,

    /// The grouping applied to the metrics that are returned. For example, when
    /// results are grouped by queue, the
    /// metrics returned are grouped by queue. The values that are returned apply to
    /// the metrics for each queue. They are not
    /// aggregated for all queues.
    ///
    /// If no grouping is specified, a summary of all metrics is returned.
    ///
    /// Valid grouping keys: `AGENT` | `AGENT_HIERARCHY_LEVEL_ONE` |
    /// `AGENT_HIERARCHY_LEVEL_TWO` | `AGENT_HIERARCHY_LEVEL_THREE` |
    /// `AGENT_HIERARCHY_LEVEL_FOUR` | `AGENT_HIERARCHY_LEVEL_FIVE` |
    /// `ANSWERING_MACHINE_DETECTION_STATUS` | `BOT_ID` | `BOT_ALIAS` |
    /// `BOT_VERSION` | `BOT_LOCALE` | `BOT_INTENT_NAME` | `CAMPAIGN` |
    /// `CAMPAIGN_DELIVERY_EVENT_TYPE` | `CAMPAIGN_EXCLUDED_EVENT_TYPE` |
    /// `CAMPAIGN_EXECUTION_TIMESTAMP` | `CASE_TEMPLATE_ARN` | `CASE_STATUS` |
    /// `CHANNEL` | `contact/segmentAttributes/connect:Subtype` |
    /// `DISCONNECT_REASON` |
    /// `EVALUATION_FORM` | `EVALUATION_SECTION` | `EVALUATION_QUESTION` |
    /// `EVALUATION_SOURCE` | `EVALUATOR_ID` | `FLOWS_RESOURCE_ID` |
    /// `FLOWS_MODULE_RESOURCE_ID` | `FLOW_ACTION_ID` | `FLOW_TYPE` |
    /// `FLOWS_OUTCOME_TYPE` | `FORM_VERSION` | `INITIATION_METHOD` |
    /// `INVOKING_RESOURCE_PUBLISHED_TIMESTAMP` | `INVOKING_RESOURCE_TYPE` |
    /// `PARENT_FLOWS_RESOURCE_ID` | `Q_CONNECT_ENABLED` | `QUEUE` |
    /// `RESOURCE_PUBLISHED_TIMESTAMP` | `ROUTING_PROFILE` |
    /// `ROUTING_STEP_EXPRESSION` |
    /// `TEST_CASE` | `TEST_CASE_EXECUTION_FAILURE_REASON` |
    /// `TEST_CASE_INVOCATION_METHOD`
    ///
    /// API, SCHEDULE, and EVENT are the only valid filterValues for
    /// TEST_CASE_INVOCATION_METHOD.
    ///
    /// OBSERVE_EVENT, SEND_INSTRUCTION, ASSERT_DATA, and OVERRIDE_SYSTEM_BEHAVIOR
    /// are the only valid filterValues for
    /// TEST_CASE_EXECUTION_FAILURE_REASON
    ///
    /// Type: Array of strings
    ///
    /// Array Members: Maximum number of 4 items
    ///
    /// Required: No
    groupings: ?[]const []const u8 = null,

    /// The interval period and timezone to apply to returned metrics.
    ///
    /// * `IntervalPeriod`: An aggregated grouping applied to request metrics. Valid
    /// `IntervalPeriod` values are: `FIFTEEN_MIN` | `THIRTY_MIN` | `HOUR` |
    /// `DAY` | `WEEK` | `TOTAL`.
    ///
    /// For example, if `IntervalPeriod` is selected `THIRTY_MIN`, `StartTime` and
    /// `EndTime` differs by 1 day, then Amazon Connect returns 48 results in the
    /// response. Each result is
    /// aggregated by the THIRTY_MIN period. By default Amazon Connect aggregates
    /// results based on the
    /// `TOTAL` interval period.
    ///
    /// The following list describes restrictions on `StartTime` and `EndTime` based
    /// on which
    /// `IntervalPeriod` is requested.
    ///
    /// * `FIFTEEN_MIN`: The difference between `StartTime` and `EndTime` must be
    /// less than 3 days.
    ///
    /// * `THIRTY_MIN`: The difference between `StartTime` and `EndTime` must be
    ///   less
    /// than 3 days.
    ///
    /// * `HOUR`: The difference between `StartTime` and `EndTime` must be less than
    /// 3 days.
    ///
    /// * `DAY`: The difference between `StartTime` and `EndTime` must be less than
    /// 35 days.
    ///
    /// * `WEEK`: The difference between `StartTime` and `EndTime` must be less than
    /// 35 days.
    ///
    /// * `TOTAL`: The difference between `StartTime` and `EndTime` must be less
    ///   than
    /// 35 days.
    ///
    /// * `TimeZone`: The timezone applied to requested metrics.
    interval: ?IntervalDetails = null,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The metrics to retrieve. Specify the name or metricId, groupings, and
    /// filters for each metric. The following
    /// historical metrics are available. For a description of each metric, see
    /// [Metrics
    /// definition](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html) in the *Amazon Connect Administrator Guide*.
    ///
    /// MetricId should be used to reference custom metrics or out of the box
    /// metrics as Arn. If using MetricId, the
    /// limit is 20 MetricId per request.
    ///
    /// **ABANDONMENT_RATE**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Feature,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Abandonment
    /// rate](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#abandonment-rate)
    ///
    /// **AGENT_ADHERENT_TIME**
    ///
    /// This metric is available only in Amazon Web Services Regions where
    /// [Forecasting, capacity planning, and
    /// scheduling](https://docs.aws.amazon.com/connect/latest/adminguide/regions.html#optimization_region) is available.
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy
    ///
    /// UI name: [Adherent
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#adherent-time)
    ///
    /// **AGENT_ANSWER_RATE**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy
    ///
    /// UI name: [Agent answer
    /// rate](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#agent-answer-rate)
    ///
    /// **AGENT_NON_ADHERENT_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy
    ///
    /// UI name: [Non-adherent
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#non-adherent-time)
    ///
    /// **AGENT_NON_RESPONSE**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy
    ///
    /// UI name: [Agent
    /// non-response](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#agent-non-response)
    ///
    /// **AGENT_NON_RESPONSE_WITHOUT_CUSTOMER_ABANDONS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy
    ///
    /// Data for this metric is available starting from October 1, 2023 0:00:00 GMT.
    ///
    /// UI name: [Agent
    /// non-response without customer
    /// abandons](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#agent-non-response-without-customer-abandons)
    ///
    /// **AGENT_OCCUPANCY**
    ///
    /// Unit: Percentage
    ///
    /// Valid groupings and filters: Routing Profile, Agent, Agent Hierarchy
    ///
    /// UI name:
    /// [Occupancy](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#occupancy)
    ///
    /// **AGENT_SCHEDULE_ADHERENCE**
    ///
    /// This metric is available only in Amazon Web Services Regions where
    /// [Forecasting, capacity planning, and
    /// scheduling](https://docs.aws.amazon.com/connect/latest/adminguide/regions.html#optimization_region) is available.
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy
    ///
    /// UI name:
    /// [Adherence](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#adherence)
    ///
    /// **AGENT_SCHEDULED_TIME**
    ///
    /// This metric is available only in Amazon Web Services Regions where
    /// [Forecasting, capacity planning, and
    /// scheduling](https://docs.aws.amazon.com/connect/latest/adminguide/regions.html#optimization_region) is available.
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy
    ///
    /// UI name: [Scheduled
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#scheduled-time)
    ///
    /// **AVG_ABANDON_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Feature,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// Valid metric filter key: `INITIATION_METHOD`
    ///
    /// UI name: [Average queue abandon
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-queue-abandon-time)
    ///
    /// **AVG_ACTIVE_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [Average active
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-active-time)
    ///
    /// **AVG_AFTER_CONTACT_WORK_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid metric filter key: `INITIATION_METHOD`
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Feature,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average after contact work
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#after-contact-work-time)
    ///
    /// Feature is a valid filter but not a valid grouping.
    ///
    /// **AVG_AGENT_CONCURRENCY**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [Average agent
    /// concurrency](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-concurrency)
    ///
    /// **AVG_AGENT_CONNECTING_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid metric filter key: `INITIATION_METHOD`. For now, this metric only
    /// supports the following as
    /// `INITIATION_METHOD`: `INBOUND` | `OUTBOUND` | `CALLBACK` |
    /// `API`
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy
    ///
    /// UI name: [Average agent API
    /// connecting
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-api-connecting-time)
    ///
    /// The `Negate` key in metric-level filters is not applicable for this metric.
    ///
    /// **AVG_AGENT_PAUSE_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [Average agent pause
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-pause-time)
    ///
    /// **AVG_BOT_CONVERSATION_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Channel,
    /// contact/segmentAttributes/connect:Subtype, Bot ID, Bot alias, Bot version,
    /// Bot locale,
    /// Flows resource ID, Flows module resource ID, Flow type, Flow action ID,
    /// Invoking resource published timestamp,
    /// Initiation method, Invoking resource type, Parent flows resource ID
    ///
    /// UI name: [Average bot conversation
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/bot-metrics.html#average-bot-conversation-time)
    ///
    /// **AVG_BOT_CONVERSATION_TURNS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Channel,
    /// contact/segmentAttributes/connect:Subtype, Bot ID, Bot alias, Bot version,
    /// Bot locale,
    /// Flows resource ID, Flows module resource ID, Flow type, Flow action ID,
    /// Invoking resource published timestamp,
    /// Initiation method, Invoking resource type, Parent flows resource ID
    ///
    /// UI name: [Average bot conversation
    /// turns](https://docs.aws.amazon.com/connect/latest/adminguide/bot-metrics.html#average-bot-conversation-turns)
    ///
    /// **AVG_CASE_RELATED_CONTACTS**
    ///
    /// Unit: Count
    ///
    /// Required filter key: CASE_TEMPLATE_ARN
    ///
    /// Valid groupings and filters: CASE_TEMPLATE_ARN, CASE_STATUS
    ///
    /// UI name: [Average contacts per
    /// case](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-contacts-per-case)
    ///
    /// **AVG_CASE_RESOLUTION_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Required filter key: CASE_TEMPLATE_ARN
    ///
    /// Valid groupings and filters: CASE_TEMPLATE_ARN, CASE_STATUS
    ///
    /// UI name: [Average case resolution
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-case-resolution-time)
    ///
    /// **AVG_CONTACT_DURATION**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Feature,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average contact
    /// duration](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-contact-duration)
    ///
    /// Feature is a valid filter but not a valid grouping.
    ///
    /// **AVG_CONTACT_FIRST_RESPONSE_TIME_AGENT**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason,
    /// Feature, RoutingStepExpression, Initiation method, Routing Profile, Queue, Q
    /// in Connect
    ///
    /// UI name: [Agent
    /// average contact first response wait
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#agent-average-contact-first-response-wait-time)
    ///
    /// **AVG_CONVERSATION_CLOSE_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason,
    /// Feature, RoutingStepExpression, Initiation method, Routing Profile, Queue, Q
    /// in Connect
    ///
    /// UI name: [Average conversation
    /// close
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-conversation-close-time)
    ///
    /// **AVG_CONVERSATION_DURATION**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Feature,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average conversation
    /// duration](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-conversation-duration)
    ///
    /// **AVG_DIALS_PER_MINUTE**
    ///
    /// This metric is available only for outbound campaigns that use the agent
    /// assisted voice and automated voice
    /// delivery modes.
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Agent, Campaign, Queue, Routing Profile
    ///
    /// UI name: [Average dials per
    /// minute](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-dials-per-minute)
    ///
    /// **AVG_EVALUATION_SCORE**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel, Evaluation
    /// Form ID, Evaluation Section ID, Evaluation Question
    /// ID, Evaluation Source, Form Version, Queue, Routing Profile
    ///
    /// UI name: [Average evaluation
    /// score](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-evaluation-score)
    ///
    /// **AVG_FIRST_RESPONSE_TIME_AGENT**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason,
    /// Feature, RoutingStepExpression, Initiation method, Routing Profile, Queue, Q
    /// in Connect
    ///
    /// UI name: [Average agent first
    /// response
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-first-response-time)
    ///
    /// **AVG_FLOW_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Channel,
    /// contact/segmentAttributes/connect:Subtype, Flow type, Flows module resource
    /// ID, Flows
    /// next resource ID, Flows next resource queue ID, Flows outcome type, Flows
    /// resource ID, Initiation method, Resource
    /// published timestamp
    ///
    /// UI name: [Average flow
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-flow-time)
    ///
    /// **AVG_GREETING_TIME_AGENT**
    ///
    /// This metric is available only for contacts analyzed by Contact Lens
    /// conversational analytics.
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average agent greeting
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-greeting-time)
    ///
    /// **AVG_HANDLE_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Feature,
    /// contact/segmentAttributes/connect:Subtype, RoutingStepExpression
    ///
    /// UI name: [Average handle
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-handle-time)
    ///
    /// Feature is a valid filter but not a valid grouping.
    ///
    /// **ACTIVE_AI_AGENTS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Agent, AI Agent Name, AI Agent Type, AI Use
    /// Case, Channel, Queue, Routing
    /// Profile
    ///
    /// UI name: Active AI Agents
    ///
    /// **AI_HANDOFF_RATE**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: AI Use Case, Channel, Queue, Routing Profile
    ///
    /// UI name: Handoff Rate
    ///
    /// **AI_HANDOFFS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Use Case, Channel, Queue, Routing Profile
    ///
    /// UI name: AI Handoff Count
    ///
    /// **AI_AGENT_INVOCATION_SUCCESS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Agent, AI Agent Name, AI Agent Name Version,
    /// AI Agent Type, AI Use Case,
    /// Channel, Queue, Routing Profile
    ///
    /// UI name: AI Agent Invocation Success Count
    ///
    /// AI Agent Name Version is not a valid filter but a valid grouping.
    ///
    /// **AI_AGENT_INVOCATION_SUCCESS_RATE**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: AI Agent, AI Agent Name, AI Agent Name Version,
    /// AI Agent Type, AI Use Case,
    /// Channel, Queue, Routing Profile
    ///
    /// UI name: AI Agent Invocation Success Rate
    ///
    /// AI Agent Name Version is not a valid filter but a valid grouping.
    ///
    /// **AI_AGENT_INVOCATIONS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Agent, AI Agent Name, AI Agent Type, AI
    /// Agent Name Version, AI Use Case,
    /// Channel, Queue, Routing Profile
    ///
    /// UI name: AI Agent Invocation Count
    ///
    /// AI Agent Name Version is not a valid filter but a valid grouping.
    ///
    /// **AI_RESPONSE_COMPLETION_RATE**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: AI Use Case, Channel, Queue, Routing Profile
    ///
    /// UI name: AI Response Completion Rate
    ///
    /// **AI_INVOLVED_CONTACTS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Use Case, Channel, Queue, Routing Profile
    ///
    /// UI name: AI Contacts
    ///
    /// **AI_PROMPT_INVOCATION_SUCCESS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Agent, AI Agent Name, AI Agent Name Version,
    /// AI Agent Type, AI Prompt, AI
    /// Prompt ID, AI Prompt Name, AI Prompt Type, AI Use Case, Channel, Queue,
    /// Routing Profile
    ///
    /// UI name: AI Prompt Invocation Success Count
    ///
    /// AI Agent Name Version is not a valid filter but a valid grouping.
    ///
    /// **AI_PROMPT_INVOCATION_SUCCESS_RATE**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: AI Agent, AI Agent Name, AI Agent Name Version,
    /// AI Agent Type, AI Prompt, AI
    /// Prompt ID, AI Prompt Name, AI Prompt Type, AI Use Case, Channel, Queue,
    /// Routing Profile
    ///
    /// UI name: AI Prompt Invocation Success Rate
    ///
    /// AI Agent Name Version is not a valid filter but a valid grouping.
    ///
    /// **AI_TOOL_INVOCATIONS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Agent, AI Agent Name, AI Agent Name Version,
    /// AI Agent Type, AI Tool ID, AI
    /// Tool Name, AI Tool Type, AI Use Case, Channel, Queue, Routing Profile
    ///
    /// UI name: AI Tool Invocation Count
    ///
    /// AI Agent Name Version is not a valid filter but a valid grouping.
    ///
    /// **AVG_AI_AGENT_CONVERSATION_TURNS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Agent, AI Agent Name, AI Agent Name Version,
    /// AI Agent Type, AI Use Case,
    /// Channel, Queue, Routing Profile
    ///
    /// UI name: Average AI Agent Conversation Turns
    ///
    /// AI Agent Name Version is not a valid filter but a valid grouping.
    ///
    /// **AVG_AI_CONVERSATION_TURNS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Use Case, Channel, Queue, Routing Profile
    ///
    /// UI name: AI Conversation Turns
    ///
    /// **AVG_AI_PROMPT_INVOCATION_LATENCY**
    ///
    /// Unit: Milliseconds
    ///
    /// Valid groupings and filters: AI Agent, AI Agent Name, AI Agent Name Version,
    /// AI Agent Type, AI Prompt, AI
    /// Prompt ID, AI Prompt Name, AI Prompt Type, AI Use Case, Channel, Queue,
    /// Routing Profile
    ///
    /// UI name: Average AI Prompt Invocation Latency
    ///
    /// AI Agent Name Version is not a valid filter but a valid grouping.
    ///
    /// **AVG_AI_TOOL_INVOCATION_LATENCY**
    ///
    /// Unit: Milliseconds
    ///
    /// Valid groupings and filters: AI Agent, AI Agent Name, AI Agent Name Version,
    /// AI Agent Type, AI Tool ID, AI
    /// Tool Name, AI Tool Type, AI Use Case, Channel, Queue, Routing Profile
    ///
    /// UI name: Average AI Tool Invocation Latency
    ///
    /// AI Agent Name Version is not a valid filter but a valid grouping.
    ///
    /// **KNOWLEDGE_CONTENT_REFERENCES**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Agent, AI Agent Name, AI Agent Type, AI Use
    /// Case, Channel, Knowledge Base
    /// Name, Queue, Routing Profile
    ///
    /// UI name: KnowledgeBase Reference Count
    ///
    /// **PROACTIVE_INTENT_ENGAGEMENT_RATE**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: AI Use Case, Channel, Queue, Routing Profile
    ///
    /// UI name: Proactive Intent Engagement Rate
    ///
    /// **PROACTIVE_INTENT_RESPONSE_RATE**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: AI Use Case, Channel, Queue, Routing Profile
    ///
    /// UI name: Proactive Intent Response Rate
    ///
    /// **PROACTIVE_INTENTS_ANSWERED**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Use Case, Channel, Queue, Routing Profile
    ///
    /// UI name: Proactive Intents Answered
    ///
    /// **PROACTIVE_INTENTS_DETECTED**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Use Case, Channel, Queue, Routing Profile
    ///
    /// UI name: Proactive Intents Detected
    ///
    /// ** **
    ///
    /// Unit:
    ///
    /// Valid groupings and filters:
    ///
    /// UI name:
    ///
    /// ** **
    ///
    /// Unit:
    ///
    /// Valid groupings and filters:
    ///
    /// UI name:
    ///
    /// **PROACTIVE_INTENTS_ENGAGED**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: AI Use Case, Channel, Queue, Routing Profile
    ///
    /// UI name: UI name:
    ///
    /// **AVG_HOLD_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Feature,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average customer hold
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-customer-hold-time)
    ///
    /// Feature is a valid filter but not a valid grouping.
    ///
    /// **AVG_HOLD_TIME_ALL_CONTACTS**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average customer
    /// hold time all
    /// contacts](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-customer-hold-time-all-contacts)
    ///
    /// **AVG_HOLDS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Feature,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average
    /// holds](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-holds)
    ///
    /// Feature is a valid filter but not a valid grouping.
    ///
    /// **AVG_INTERACTION_AND_HOLD_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average
    /// agent interaction and customer hold
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-interaction-and-customer-hold-time)
    ///
    /// **AVG_INTERACTION_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid metric filter key: `INITIATION_METHOD`
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Feature,
    /// contact/segmentAttributes/connect:Subtype,
    /// Q in Connect
    ///
    /// UI name: [Average agent interaction
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-interaction-time)
    ///
    /// Feature is a valid filter but not a valid grouping.
    ///
    /// **AVG_INTERRUPTIONS_AGENT**
    ///
    /// This metric is available only for contacts analyzed by Contact Lens
    /// conversational analytics.
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average agent
    /// interruptions](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-interruptions)
    ///
    /// **AVG_INTERRUPTION_TIME_AGENT**
    ///
    /// This metric is available only for contacts analyzed by Contact Lens
    /// conversational analytics.
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average agent
    /// interruption
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-interruption-time)
    ///
    /// **AVG_MESSAGE_LENGTH_AGENT**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason,
    /// Feature, RoutingStepExpression, Initiation method, Routing Profile, Queue, Q
    /// in Connect
    ///
    /// UI name: [Average agent message
    /// length](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-message-length)
    ///
    /// **AVG_MESSAGE_LENGTH_CUSTOMER**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason,
    /// Feature, RoutingStepExpression, Initiation method, Routing Profile, Queue, Q
    /// in Connect
    ///
    /// UI name: [Average customer message
    /// length](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-customer-message-length)
    ///
    /// **AVG_MESSAGES**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason,
    /// Feature, RoutingStepExpression, Initiation method, Routing Profile, Queue, Q
    /// in Connect
    ///
    /// UI name: [Average
    /// messages](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-messages)
    ///
    /// **AVG_MESSAGES_AGENT**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason,
    /// Feature, RoutingStepExpression, Initiation method, Routing Profile, Queue, Q
    /// in Connect
    ///
    /// UI name: [Average agent
    /// messages](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-messages)
    ///
    /// **AVG_MESSAGES_BOT**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason,
    /// Feature, RoutingStepExpression, Initiation method, Routing Profile, Queue, Q
    /// in Connect
    ///
    /// UI name: [Average bot
    /// messages](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-bot-messages)
    ///
    /// **AVG_MESSAGES_CUSTOMER**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason,
    /// Feature, RoutingStepExpression, Initiation method, Routing Profile, Queue, Q
    /// in Connect
    ///
    /// UI name: [Average customer
    /// messages](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-customer-messages)
    ///
    /// **AVG_NON_TALK_TIME**
    ///
    /// This metric is available only for contacts analyzed by Contact Lens
    /// conversational analytics.
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average non-talk
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-non-talk-time)
    ///
    /// **AVG_QUEUE_ANSWER_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Feature,
    /// contact/segmentAttributes/connect:Subtype,
    /// Q in Connect
    ///
    /// UI name: [Average queue answer
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-queue-answer-time)
    ///
    /// Valid metric level filters: `INITIATION_METHOD`, `FEATURE`,
    /// `DISCONNECT_REASON`
    ///
    /// Feature is a valid filter but not a valid grouping.
    ///
    /// **AVG_QUEUE_ANSWER_TIME_CUSTOMER_FIRST_CALLBACK**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent,
    /// Feature, contact/segmentAttributes/connect:Subtype, Q in
    /// Connect, Agent Hierarchy
    ///
    /// UI name: [Avg.
    /// queue answer time - customer first
    /// callback](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-queue-answer-time-customer-first-callback)
    ///
    /// **AVG_RESPONSE_TIME_AGENT**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason,
    /// Feature, RoutingStepExpression, Initiation method, Routing Profile, Queue, Q
    /// in Connect
    ///
    /// UI name: [Average agent response
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-response-time-agent)
    ///
    /// **AVG_RESPONSE_TIME_CUSTOMER**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason,
    /// Feature, RoutingStepExpression, Initiation method, Routing Profile, Queue, Q
    /// in Connect
    ///
    /// UI name: [Average customer response
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-customer-time-agent)
    ///
    /// **AVG_RESOLUTION_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average resolution
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-resolution-time)
    ///
    /// **AVG_TALK_TIME**
    ///
    /// This metric is available only for contacts analyzed by Contact Lens
    /// conversational analytics.
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average talk
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-talk-time)
    ///
    /// **AVG_TALK_TIME_AGENT**
    ///
    /// This metric is available only for contacts analyzed by Contact Lens
    /// conversational analytics.
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average agent talk
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-agent-talk-time)
    ///
    /// **AVG_TALK_TIME_CUSTOMER**
    ///
    /// This metric is available only for contacts analyzed by Contact Lens
    /// conversational analytics.
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Average customer talk
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-customer-talk-time)
    ///
    /// **AVG_WAIT_TIME_AFTER_CUSTOMER_CONNECTION**
    ///
    /// This metric is available only for outbound campaigns that use the agent
    /// assisted voice and automated voice
    /// delivery modes.
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Campaign
    ///
    /// UI name: [Average wait
    /// time after customer
    /// connection](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-wait-time-after-customer-connection)
    ///
    /// **AVG_WAIT_TIME_AFTER_CUSTOMER_FIRST_CALLBACK_CONNECTION**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent,
    /// Feature, contact/segmentAttributes/connect:Subtype, Q in
    /// Connect, Agent Hierarchy
    ///
    /// UI name: [Avg. wait time after customer connection - customer first
    /// callback](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-wait-time-after-customer-connection-customer-first-callback)
    ///
    /// **AVG_WEIGHTED_EVALUATION_SCORE**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel, Evaluation
    /// Form Id, Evaluation Section ID, Evaluation Question
    /// ID, Evaluation Source, Form Version, Queue, Routing Profile
    ///
    /// UI name: [Average weighted
    /// evaluation
    /// score](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-weighted-evaluation-score)
    ///
    /// **BOT_CONVERSATIONS_COMPLETED**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Channel,
    /// contact/segmentAttributes/connect:Subtype, Bot ID, Bot alias, Bot version,
    /// Bot locale,
    /// Flows resource ID, Flows module resource ID, Flow type, Flow action ID,
    /// Invoking resource published timestamp,
    /// Initiation method, Invoking resource type, Parent flows resource ID
    ///
    /// UI name: [Bot conversations
    /// completed](https://docs.aws.amazon.com/connect/latest/adminguide/bot-metrics.html#bot-conversations-completed)
    ///
    /// **BOT_INTENTS_COMPLETED**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Channel,
    /// contact/segmentAttributes/connect:Subtype, Bot ID, Bot alias, Bot version,
    /// Bot locale,
    /// Bot intent name, Flows resource ID, Flows module resource ID, Flow type,
    /// Flow action ID, Invoking resource
    /// published timestamp, Initiation method, Invoking resource type, Parent flows
    /// resource ID
    ///
    /// UI name: [Bot intents
    /// completed](https://docs.aws.amazon.com/connect/latest/adminguide/bot-metrics.html#bot-intents-completed)
    ///
    /// **CAMPAIGN_CONTACTS_ABANDONED_AFTER_X**
    ///
    /// This metric is available only for outbound campaigns using the agent
    /// assisted voice and automated voice
    /// delivery modes.
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Agent, Campaign
    ///
    /// Threshold: For `ThresholdValue`, enter any whole number from 1 to 604800
    /// (inclusive), in seconds.
    /// For `Comparison`, you must enter `GT` (for *Greater than*).
    ///
    /// UI name: [Campaign contacts
    /// abandoned after
    /// X](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#campaign-contacts-abandoned-after-x)
    ///
    /// **CAMPAIGN_CONTACTS_ABANDONED_AFTER_X_RATE**
    ///
    /// This metric is available only for outbound campaigns using the agent
    /// assisted voice and automated voice
    /// delivery modes.
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Agent, Campaign
    ///
    /// Threshold: For `ThresholdValue`, enter any whole number from 1 to 604800
    /// (inclusive), in seconds.
    /// For `Comparison`, you must enter `GT` (for *Greater than*).
    ///
    /// UI name: [Campaign
    /// contacts abandoned after X
    /// rate](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#campaign-contacts-abandoned-after-x-rate)
    ///
    /// **CAMPAIGN_INTERACTIONS**
    ///
    /// This metric is available only for outbound campaigns using the email
    /// delivery mode.
    ///
    /// Unit: Count
    ///
    /// Valid metric filter key: CAMPAIGN_INTERACTION_EVENT_TYPE
    ///
    /// Valid groupings and filters: Campaign
    ///
    /// UI name: [Campaign
    /// interactions](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#campaign-interactions)
    ///
    /// **CAMPAIGN_PROGRESS_RATE**
    ///
    /// This metric is only available for outbound campaigns initiated using a
    /// customer segment. It is not available
    /// for event triggered campaigns.
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Campaign, Campaign Execution Timestamp
    ///
    /// UI name: [Campaign progress
    /// rate](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#campaign-progress-rate)
    ///
    /// **CAMPAIGN_SEND_ATTEMPTS**
    ///
    /// This metric is available only for outbound campaigns.
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Campaign, Channel,
    /// contact/segmentAttributes/connect:Subtype
    ///
    /// UI name: [Campaign send
    /// attempts](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#campaign-send-attempts)
    ///
    /// **CAMPAIGN_SEND_EXCLUSIONS**
    ///
    /// This metric is available only for outbound campaigns.
    ///
    /// Valid metric filter key: CAMPAIGN_EXCLUDED_EVENT_TYPE
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Campaign, Campaign Excluded Event Type,
    /// Campaign Execution Timestamp
    ///
    /// UI name: [Campaign send
    /// exclusions](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#campaign-send-exclusions)
    ///
    /// **CASES_CREATED**
    ///
    /// Unit: Count
    ///
    /// Required filter key: CASE_TEMPLATE_ARN
    ///
    /// Valid groupings and filters: CASE_TEMPLATE_ARN, CASE_STATUS
    ///
    /// UI name: [Cases
    /// created](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#cases-created)
    ///
    /// **CONTACTS_CREATED**
    ///
    /// Unit: Count
    ///
    /// Valid metric filter key: `INITIATION_METHOD`
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Feature,
    /// contact/segmentAttributes/connect:Subtype,
    /// Q in Connect
    ///
    /// UI name: [Contacts
    /// created](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-created)
    ///
    /// Feature is a valid filter but not a valid grouping.
    ///
    /// **CONTACTS_HANDLED**
    ///
    /// Unit: Count
    ///
    /// Valid metric filter key: `INITIATION_METHOD`, `DISCONNECT_REASON`
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Feature,
    /// contact/segmentAttributes/connect:Subtype, RoutingStepExpression, Q in
    /// Connect
    ///
    /// UI name: [Contacts
    /// handled](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-handled)
    ///
    /// Feature is a valid filter but not a valid grouping.
    ///
    /// **CONTACTS_HANDLED_BY_CONNECTED_TO_AGENT**
    ///
    /// Unit: Count
    ///
    /// Valid metric filter key: `INITIATION_METHOD`
    ///
    /// Valid groupings and filters: Queue, Channel, Agent, Agent Hierarchy,
    /// contact/segmentAttributes/connect:Subtype,
    /// Q in Connect
    ///
    /// UI name: [Contacts handled (connected to agent
    /// timestamp)](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-handled-by-connected-to-agent-timestamp)
    ///
    /// **CONTACTS_HOLD_ABANDONS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Contacts hold
    /// disconnect](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-hold-disconnect)
    ///
    /// **CONTACTS_ON_HOLD_AGENT_DISCONNECT**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [Contacts hold agent
    /// disconnect](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-hold-agent-disconnect)
    ///
    /// **CONTACTS_ON_HOLD_CUSTOMER_DISCONNECT**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [Contacts hold customer
    /// disconnect](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-hold-customer-disconnect)
    ///
    /// **CONTACTS_PUT_ON_HOLD**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [Contacts put on
    /// hold](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-put-on-hold)
    ///
    /// **CONTACTS_TRANSFERRED_OUT_EXTERNAL**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [Contacts transferred
    /// out
    /// external](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-transferred-out-external)
    ///
    /// **CONTACTS_TRANSFERRED_OUT_INTERNAL**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [Contacts transferred
    /// out
    /// internal](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-transferred-out-internal)
    ///
    /// **CONTACTS_QUEUED**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Contacts
    /// queued](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-queued)
    ///
    /// **CONTACTS_QUEUED_BY_ENQUEUE**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Agent, Agent Hierarchy,
    /// contact/segmentAttributes/connect:Subtype
    ///
    /// UI name: [Contacts queued (enqueue
    /// timestamp)](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-queued-by-enqueue)
    ///
    /// **CONTACTS_REMOVED_FROM_QUEUE_IN_X**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Q in Connect
    ///
    /// Threshold: For `ThresholdValue`, enter any whole number from 1 to 604800
    /// (inclusive), in seconds.
    /// For `Comparison`, you can use `LT` (for "Less than") or `LTE` (for "Less
    /// than
    /// equal").
    ///
    /// UI name: [Contacts removed from queue
    /// in X
    /// seconds](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-removed-from-queue)
    ///
    /// **CONTACTS_RESOLVED_IN_X**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// Threshold: For `ThresholdValue`, enter any whole number from 1 to 604800
    /// (inclusive), in seconds.
    /// For `Comparison`, you can use `LT` (for "Less than") or `LTE` (for "Less
    /// than
    /// equal").
    ///
    /// UI name: [Contacts resolved in
    /// X](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-resolved)
    ///
    /// **CONTACTS_TRANSFERRED_OUT**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Feature,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Contacts transferred
    /// out](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-transferred-out)
    ///
    /// Feature is a valid filter but not a valid grouping.
    ///
    /// **CONTACTS_TRANSFERRED_OUT_BY_AGENT**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Contacts transferred
    /// out by
    /// agent](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-transferred-out-by-agent)
    ///
    /// **CONTACTS_TRANSFERRED_OUT_FROM_QUEUE**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Contacts transferred out
    /// queue](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-transferred-out-queue)
    ///
    /// **CURRENT_CASES**
    ///
    /// Unit: Count
    ///
    /// Required filter key: CASE_TEMPLATE_ARN
    ///
    /// Valid groupings and filters: CASE_TEMPLATE_ARN, CASE_STATUS
    ///
    /// UI name: [Current
    /// cases](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#current-cases)
    ///
    /// **CONVERSATIONS_ABANDONED**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason,
    /// Feature, RoutingStepExpression, Initiation method, Routing Profile, Queue, Q
    /// in Connect
    ///
    /// UI name: [Conversations
    /// abandoned](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#conversations-abandoned)
    ///
    /// **DELIVERY_ATTEMPTS**
    ///
    /// This metric is available only for outbound campaigns.
    ///
    /// Unit: Count
    ///
    /// Valid metric filter key: `ANSWERING_MACHINE_DETECTION_STATUS`,
    /// `CAMPAIGN_DELIVERY_EVENT_TYPE`, `DISCONNECT_REASON`
    ///
    /// Valid groupings and filters: Agent, Answering Machine Detection Status,
    /// Campaign, Campaign Delivery EventType, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason, Queue, Routing
    /// Profile
    ///
    /// UI name: [Delivery
    /// attempts](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#delivery-attempts)
    ///
    /// Campaign Delivery EventType filter and grouping are only available for SMS
    /// and Email campaign delivery
    /// modes. Agent, Queue, Routing Profile, Answering Machine Detection Status and
    /// Disconnect Reason are only available
    /// for agent assisted voice and automated voice delivery modes.
    ///
    /// **DELIVERY_ATTEMPT_DISPOSITION_RATE**
    ///
    /// This metric is available only for outbound campaigns. Dispositions for the
    /// agent assisted voice and automated
    /// voice delivery modes are only available with answering machine detection
    /// enabled.
    ///
    /// Unit: Percent
    ///
    /// Valid metric filter key: `ANSWERING_MACHINE_DETECTION_STATUS`,
    /// `CAMPAIGN_DELIVERY_EVENT_TYPE`, `DISCONNECT_REASON`
    ///
    /// Valid groupings and filters: Agent, Answering Machine Detection Status,
    /// Campaign, Channel,
    /// contact/segmentAttributes/connect:Subtype, Disconnect Reason, Queue, Routing
    /// Profile
    ///
    /// UI name: [Delivery attempt
    /// disposition
    /// rate](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#delivery-attempt-disposition-rate)
    ///
    /// Campaign Delivery Event Type filter and grouping are only available for SMS
    /// and Email campaign delivery
    /// modes. Agent, Queue, Routing Profile, Answering Machine Detection Status and
    /// Disconnect Reason are only available
    /// for agent assisted voice and automated voice delivery modes.
    ///
    /// **EVALUATIONS_PERFORMED**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel, Evaluation
    /// Form ID, Evaluation Source, Form Version, Queue,
    /// Routing Profile
    ///
    /// UI name: [Evaluations
    /// performed](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#evaluations-performed)
    ///
    /// **FLOWS_OUTCOME**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Channel,
    /// contact/segmentAttributes/connect:Subtype, Flow type, Flows module resource
    /// ID, Flows
    /// next resource ID, Flows next resource queue ID, Flows outcome type, Flows
    /// resource ID, Initiation method, Resource
    /// published timestamp
    ///
    /// UI name: [Flows
    /// outcome](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#flows-outcome)
    ///
    /// **FLOWS_STARTED**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Channel,
    /// contact/segmentAttributes/connect:Subtype, Flow type, Flows module resource
    /// ID, Flows
    /// resource ID, Initiation method, Resource published timestamp
    ///
    /// UI name: [Flows
    /// started](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#flows-started)
    ///
    /// **HUMAN_ANSWERED_CALLS**
    ///
    /// This metric is available only for outbound campaigns. Dispositions for the
    /// agent assisted voice and automated
    /// voice delivery modes are only available with answering machine detection
    /// enabled.
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Agent, Campaign
    ///
    /// UI name: [Human
    /// answered](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#human-answered)
    ///
    /// **MAX_FLOW_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Channel,
    /// contact/segmentAttributes/connect:Subtype, Flow type, Flows module resource
    /// ID, Flows
    /// next resource ID, Flows next resource queue ID, Flows outcome type, Flows
    /// resource ID, Initiation method, Resource
    /// published timestamp
    ///
    /// UI name: [Maximum flow
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#maximum-flow-time)
    ///
    /// **MAX_QUEUED_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Maximum queued
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#maximum-queued-time)
    ///
    /// **MIN_FLOW_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Channel,
    /// contact/segmentAttributes/connect:Subtype, Flow type, Flows module resource
    /// ID, Flows
    /// next resource ID, Flows next resource queue ID, Flows outcome type, Flows
    /// resource ID, Initiation method, Resource
    /// published timestamp
    ///
    /// UI name: [Minimum flow
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#minimum-flow-time)
    ///
    /// **PERCENT_AUTOMATIC_FAILS**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Agent, Agent Hierarchy, Channel, Evaluation
    /// Form ID, Evaluation Source, Form Version, Queue,
    /// Routing Profile
    ///
    /// UI name: [Automatic fails
    /// percent](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#automatic-fails-percent)
    ///
    /// **PERCENT_BOT_CONVERSATIONS_OUTCOME**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Channel,
    /// contact/segmentAttributes/connect:Subtype, Bot ID, Bot alias, Bot version,
    /// Bot locale,
    /// Flows resource ID, Flows module resource ID, Flow type, Flow action ID,
    /// Invoking resource published timestamp,
    /// Initiation method, Invoking resource type, Parent flows resource ID
    ///
    /// UI name: [Percent bot conversations
    /// outcome](https://docs.aws.amazon.com/connect/latest/adminguide/bot-metrics.html#percent-bot-conversations-outcome)
    ///
    /// **PERCENT_BOT_INTENTS_OUTCOME**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Channel,
    /// contact/segmentAttributes/connect:Subtype, Bot ID, Bot alias, Bot version,
    /// Bot locale,
    /// Bot intent name, Flows resource ID, Flows module resource ID, Flow type,
    /// Flow action ID, Invoking resource
    /// published timestamp, Initiation method, Invoking resource type, Parent flows
    /// resource ID
    ///
    /// UI name: [Percent bot intents
    /// outcome](https://docs.aws.amazon.com/connect/latest/adminguide/bot-metrics.html#percent-bot-intents-outcome)
    ///
    /// **PERCENT_CASES_FIRST_CONTACT_RESOLVED**
    ///
    /// Unit: Percent
    ///
    /// Required filter key: CASE_TEMPLATE_ARN
    ///
    /// Valid groupings and filters: CASE_TEMPLATE_ARN, CASE_STATUS
    ///
    /// UI name: [Cases resolved on first
    /// contact](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#cases-resolved-on-first-contact)
    ///
    /// **PERCENT_CONTACTS_STEP_EXPIRED**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Queue, RoutingStepExpression
    ///
    /// UI name: This metric is available in Real-time Metrics UI but not on the
    /// Historical Metrics UI.
    ///
    /// **PERCENT_CONTACTS_STEP_JOINED**
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Queue, RoutingStepExpression
    ///
    /// UI name: This metric is available in Real-time Metrics UI but not on the
    /// Historical Metrics UI.
    ///
    /// **PERCENT_FLOWS_OUTCOME**
    ///
    /// Unit: Percent
    ///
    /// Valid metric filter key: `FLOWS_OUTCOME_TYPE`
    ///
    /// Valid groupings and filters: Channel,
    /// contact/segmentAttributes/connect:Subtype, Flow type, Flows module resource
    /// ID, Flows
    /// next resource ID, Flows next resource queue ID, Flows outcome type, Flows
    /// resource ID, Initiation method, Resource
    /// published timestamp
    ///
    /// UI name: [Flows outcome
    /// percentage](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#flows-outcome-percentage).
    ///
    /// The `FLOWS_OUTCOME_TYPE` is not a valid grouping.
    ///
    /// **PERCENT_NON_TALK_TIME**
    ///
    /// This metric is available only for contacts analyzed by Contact Lens
    /// conversational analytics.
    ///
    /// Unit: Percentage
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Non-talk time
    /// percent](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#non-talk-time-percent)
    ///
    /// **PERCENT_TALK_TIME**
    ///
    /// This metric is available only for contacts analyzed by Contact Lens
    /// conversational analytics.
    ///
    /// Unit: Percentage
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Talk time
    /// percent](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#talk-time-percent)
    ///
    /// **PERCENT_TALK_TIME_AGENT**
    ///
    /// This metric is available only for contacts analyzed by Contact Lens
    /// conversational analytics.
    ///
    /// Unit: Percentage
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Agent talk time
    /// percent](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#agent-talk-time-percent)
    ///
    /// **PERCENT_TALK_TIME_CUSTOMER**
    ///
    /// This metric is available only for contacts analyzed by Contact Lens
    /// conversational analytics.
    ///
    /// Unit: Percentage
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Customer talk time
    /// percent](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#customer-talk-time-percent)
    ///
    /// **RECIPIENTS_ATTEMPTED**
    ///
    /// This metric is only available for outbound campaigns initiated using a
    /// customer segment. It is not available
    /// for event triggered campaigns.
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Campaign, Campaign Execution Timestamp
    ///
    /// UI name: [Recipients
    /// attempted](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#recipients-attempted)
    ///
    /// **RECIPIENTS_INTERACTED**
    ///
    /// This metric is only available for outbound campaigns initiated using a
    /// customer segment. It is not available
    /// for event triggered campaigns.
    ///
    /// Valid metric filter key: CAMPAIGN_INTERACTION_EVENT_TYPE
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Campaign, Channel,
    /// contact/segmentAttributes/connect:Subtype, Campaign Execution
    /// Timestamp
    ///
    /// UI name: [Recipients
    /// interacted](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#recipients-interacted)
    ///
    /// **RECIPIENTS_TARGETED**
    ///
    /// This metric is only available for outbound campaigns initiated using a
    /// customer segment. It is not available
    /// for event triggered campaigns.
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Campaign, Campaign Execution Timestamp
    ///
    /// UI name: [Recipients
    /// targeted](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#recipients-targeted)
    ///
    /// **REOPENED_CASE_ACTIONS**
    ///
    /// Unit: Count
    ///
    /// Required filter key: CASE_TEMPLATE_ARN
    ///
    /// Valid groupings and filters: CASE_TEMPLATE_ARN, CASE_STATUS
    ///
    /// UI name: [Cases
    /// reopened](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#cases-reopened)
    ///
    /// **RESOLVED_CASE_ACTIONS**
    ///
    /// Unit: Count
    ///
    /// Required filter key: CASE_TEMPLATE_ARN
    ///
    /// Valid groupings and filters: CASE_TEMPLATE_ARN, CASE_STATUS
    ///
    /// UI name: [Cases
    /// resolved](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#cases-resolved)
    ///
    /// **SERVICE_LEVEL**
    ///
    /// You can include up to 20 SERVICE_LEVEL metrics in a request.
    ///
    /// Unit: Percent
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Q in Connect
    ///
    /// Threshold: For `ThresholdValue`, enter any whole number from 1 to 604800
    /// (inclusive), in seconds.
    /// For `Comparison`, you can use `LT` (for "Less than") or `LTE` (for "Less
    /// than
    /// equal").
    ///
    /// UI name: [Service level
    /// X](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#service-level)
    ///
    /// **STEP_CONTACTS_QUEUED**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, RoutingStepExpression
    ///
    /// UI name: This metric is available in Real-time Metrics UI but not on the
    /// Historical Metrics UI.
    ///
    /// **SUM_AFTER_CONTACT_WORK_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [After contact work
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#after-contact-work-time)
    ///
    /// **SUM_CONNECTING_TIME_AGENT**
    ///
    /// Unit: Seconds
    ///
    /// Valid metric filter key: `INITIATION_METHOD`. This metric only supports the
    /// following filter keys
    /// as `INITIATION_METHOD`: `INBOUND` | `OUTBOUND` | `CALLBACK` |
    /// `API` | `CALLBACK_CUSTOMER_FIRST_DIALED`
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy
    ///
    /// UI name: [Agent API connecting
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#agent-api-connecting-time)
    ///
    /// The `Negate` key in metric-level filters is not applicable for this metric.
    ///
    /// **CONTACTS_ABANDONED**
    ///
    /// Unit: Count
    ///
    /// Metric filter:
    ///
    /// * Valid values: `API`| `INCOMING` | `OUTBOUND` | `TRANSFER` |
    /// `CALLBACK` | `QUEUE_TRANSFER`| `Disconnect` |
    /// `CALLBACK_CUSTOMER_FIRST_DIALED`
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, RoutingStepExpression, Q in
    /// Connect
    ///
    /// UI name: [Contact
    /// abandoned](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-abandoned)
    ///
    /// **SUM_CONTACTS_ABANDONED_IN_X**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// Threshold: For `ThresholdValue`, enter any whole number from 1 to 604800
    /// (inclusive), in seconds.
    /// For `Comparison`, you can use `LT` (for "Less than") or `LTE` (for "Less
    /// than
    /// equal").
    ///
    /// UI name: [Contacts abandoned in X
    /// seconds](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-abandoned-in-x-seconds)
    ///
    /// **SUM_CONTACTS_ANSWERED_IN_X**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// Threshold: For `ThresholdValue`, enter any whole number from 1 to 604800
    /// (inclusive), in seconds.
    /// For `Comparison`, you can use `LT` (for "Less than") or `LTE` (for "Less
    /// than
    /// equal").
    ///
    /// UI name: [Contacts answered in X
    /// seconds](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contacts-answered-in-x-seconds)
    ///
    /// **SUM_CONTACT_FLOW_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [Contact flow
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contact-flow-time)
    ///
    /// **SUM_CONTACT_TIME_AGENT**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Routing Profile, Agent, Agent Hierarchy
    ///
    /// UI name: [Agent on contact
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#agent-on-contact-time)
    ///
    /// **SUM_CONTACTS_DISCONNECTED **
    ///
    /// Valid metric filter key: `DISCONNECT_REASON`
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Contact
    /// disconnected](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contact-disconnected)
    ///
    /// **SUM_ERROR_STATUS_TIME_AGENT**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Routing Profile, Agent, Agent Hierarchy
    ///
    /// UI name: [Error status
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#error-status-time)
    ///
    /// **SUM_HANDLE_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [Contact handle
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#contact-handle-time)
    ///
    /// **SUM_HOLD_TIME**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [Customer hold
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#customer-hold-time)
    ///
    /// **SUM_IDLE_TIME_AGENT**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Routing Profile, Agent, Agent Hierarchy
    ///
    /// UI name: [Agent idle
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#agent-idle-time)
    ///
    /// **SUM_INTERACTION_AND_HOLD_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy, Q in Connect
    ///
    /// UI name: [Agent interaction and
    /// hold
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#agent-interaction-and-hold-time)
    ///
    /// **SUM_INTERACTION_TIME**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile, Agent, Agent
    /// Hierarchy
    ///
    /// UI name: [Agent interaction
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#agent-interaction-time)
    ///
    /// **SUM_NON_PRODUCTIVE_TIME_AGENT**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Routing Profile, Agent, Agent Hierarchy
    ///
    /// UI name: [Agent non-productive
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#agent-non-productive-time)
    ///
    /// **SUM_ONLINE_TIME_AGENT**
    ///
    /// Unit: Seconds
    ///
    /// Valid groupings and filters: Routing Profile, Agent, Agent Hierarchy
    ///
    /// UI name: [Online
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#online-time)
    ///
    /// **SUM_RETRY_CALLBACK_ATTEMPTS**
    ///
    /// Unit: Count
    ///
    /// Valid groupings and filters: Queue, Channel, Routing Profile,
    /// contact/segmentAttributes/connect:Subtype, Q in Connect
    ///
    /// UI name: [Callback
    /// attempts](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#callback-attempts)
    metrics: []const MetricV2,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource. This includes the
    /// `instanceId` an Amazon Connect instance.
    resource_arn: []const u8,

    /// The timestamp, in UNIX Epoch time format, at which to start the reporting
    /// interval for the retrieval of
    /// historical metrics data. The time must be before the end time timestamp. The
    /// start and end time depends on the
    /// `IntervalPeriod` selected. By default the time range between start and end
    /// time is 35 days. Historical
    /// metrics are available for 3 months.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .filters = "Filters",
        .groupings = "Groupings",
        .interval = "Interval",
        .max_results = "MaxResults",
        .metrics = "Metrics",
        .next_token = "NextToken",
        .resource_arn = "ResourceArn",
        .start_time = "StartTime",
    };
};

pub const GetMetricDataV2Output = struct {
    /// Information about the metrics requested in the API request If no grouping is
    /// specified, a summary of metric data
    /// is returned.
    metric_results: ?[]const MetricResultV2 = null,

    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric_results = "MetricResults",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMetricDataV2Input, options: Options) !GetMetricDataV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "connect");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetMetricDataV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/metrics/data";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Filters\":");
    try aws.json.writeValue(@TypeOf(input.filters), input.filters, allocator, &body_buf);
    has_prev = true;
    if (input.groupings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Groupings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.interval) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Interval\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Metrics\":");
    try aws.json.writeValue(@TypeOf(input.metrics), input.metrics, allocator, &body_buf);
    has_prev = true;
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_arn), input.resource_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StartTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMetricDataV2Output {
    var result: GetMetricDataV2Output = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetMetricDataV2Output, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConditionalOperationFailedException")) {
        return .{ .arena = arena, .kind = .{ .conditional_operation_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ContactFlowNotPublishedException")) {
        return .{ .arena = arena, .kind = .{ .contact_flow_not_published_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ContactNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .contact_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DestinationNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .destination_not_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateResourceException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyException")) {
        return .{ .arena = arena, .kind = .{ .idempotency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidActiveRegionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_active_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidContactFlowException")) {
        return .{ .arena = arena, .kind = .{ .invalid_contact_flow_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidContactFlowModuleException")) {
        return .{ .arena = arena, .kind = .{ .invalid_contact_flow_module_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTestCaseException")) {
        return .{ .arena = arena, .kind = .{ .invalid_test_case_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaximumResultReturnedException")) {
        return .{ .arena = arena, .kind = .{ .maximum_result_returned_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OutboundContactNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .outbound_contact_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OutputTypeNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .output_type_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PropertyValidationException")) {
        return .{ .arena = arena, .kind = .{ .property_validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .arena = arena, .kind = .{ .resource_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .user_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
