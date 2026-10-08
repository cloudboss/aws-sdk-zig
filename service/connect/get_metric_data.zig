const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filters = @import("filters.zig").Filters;
const Grouping = @import("grouping.zig").Grouping;
const HistoricalMetric = @import("historical_metric.zig").HistoricalMetric;
const HistoricalMetricResult = @import("historical_metric_result.zig").HistoricalMetricResult;

pub const GetMetricDataInput = struct {
    /// The timestamp, in UNIX Epoch time format, at which to end the reporting
    /// interval for the retrieval of historical
    /// metrics data. The time must be specified using an interval of 5 minutes,
    /// such as 11:00, 11:05, 11:10, and must be
    /// later than the start time timestamp.
    ///
    /// The time range between the start and end time must be less than 24 hours.
    end_time: i64,

    /// The queues, up to 100, or channels, to use to filter the metrics returned.
    /// Metric data is retrieved only for the
    /// resources associated with the queues or channels included in the filter. You
    /// can include both queue IDs and queue
    /// ARNs in the same request. VOICE, CHAT, and TASK channels are supported.
    ///
    /// RoutingStepExpression is not a valid filter for GetMetricData and we
    /// recommend switching to GetMetricDataV2 for
    /// more up-to-date features.
    ///
    /// To filter by `Queues`, enter the queue ID/ARN, not the name of
    /// the queue.
    filters: Filters,

    /// The grouping applied to the metrics returned. For example, when results are
    /// grouped by queue, the metrics
    /// returned are grouped by queue. The values returned apply to the metrics for
    /// each queue rather than aggregated for all
    /// queues.
    ///
    /// If no grouping is specified, a summary of metrics for all queues is
    /// returned.
    ///
    /// RoutingStepExpression is not a valid filter for GetMetricData and we
    /// recommend switching to GetMetricDataV2 for
    /// more up-to-date features.
    groupings: ?[]const Grouping = null,

    /// The metrics to retrieve. Specify the name, unit, and statistic for each
    /// metric. The following historical metrics
    /// are available. For a description of each metric, see [Metrics
    /// definition](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html) in the *Connect Customer Administrator Guide*.
    ///
    /// This API does not support a contacts incoming metric (there's
    /// no CONTACTS_INCOMING metric missing from the documented list).
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
    /// UI name: [Average queue abandon
    /// time](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#average-queue-abandon-time)
    historical_metrics: []const HistoricalMetric,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The timestamp, in UNIX Epoch time format, at which to start the reporting
    /// interval for the retrieval of
    /// historical metrics data. The time must be specified using a multiple of 5
    /// minutes, such as 10:05, 10:10,
    /// 10:15.
    ///
    /// The start time cannot be earlier than 24 hours before the time of the
    /// request. Historical metrics are available
    /// only for 24 hours.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .filters = "Filters",
        .groupings = "Groupings",
        .historical_metrics = "HistoricalMetrics",
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .start_time = "StartTime",
    };
};

pub const GetMetricDataOutput = struct {
    /// Information about the historical metrics.
    ///
    /// If no grouping is specified, a summary of metric data is returned.
    metric_results: ?[]const HistoricalMetricResult = null,

    /// If there are additional results, this is the token for the next set of
    /// results.
    ///
    /// The token expires after 5 minutes from the time it is created. Subsequent
    /// requests that use
    /// the token must use the same request parameters as the request that generated
    /// the token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric_results = "MetricResults",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMetricDataInput, options: CallOptions) !GetMetricDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetMetricDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/metrics/historical/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"HistoricalMetrics\":");
    try aws.json.writeValue(@TypeOf(input.historical_metrics), input.historical_metrics, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StartTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMetricDataOutput {
    const result: GetMetricDataOutput = try aws.json.parseJsonObject(
        GetMetricDataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
