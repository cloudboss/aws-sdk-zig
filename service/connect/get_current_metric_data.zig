const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CurrentMetric = @import("current_metric.zig").CurrentMetric;
const Filters = @import("filters.zig").Filters;
const Grouping = @import("grouping.zig").Grouping;
const CurrentMetricSortCriteria = @import("current_metric_sort_criteria.zig").CurrentMetricSortCriteria;
const CurrentMetricResult = @import("current_metric_result.zig").CurrentMetricResult;

pub const GetCurrentMetricDataInput = struct {
    /// The metrics to retrieve. Specify the name or metricId, and unit for each
    /// metric. The following metrics are available. For a
    /// description of all the metrics, see [Metrics
    /// definitions](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html) in the *Amazon Connect Administrator Guide*.
    ///
    /// MetricId should be used to reference custom metrics or out of the box
    /// metrics as Arn. If using MetricId, the limit is 10 MetricId per request.
    ///
    /// **AGENTS_AFTER_CONTACT_WORK**
    ///
    /// Unit: COUNT
    ///
    /// Name in real-time metrics report:
    /// [ACW](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#aftercallwork-real-time)
    ///
    /// **AGENTS_AVAILABLE**
    ///
    /// Unit: COUNT
    ///
    /// Name in real-time metrics report:
    /// [Available](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#available-real-time)
    ///
    /// **AGENTS_ERROR**
    ///
    /// Unit: COUNT
    ///
    /// Name in real-time metrics report:
    /// [Error](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#error-real-time)
    ///
    /// **AGENTS_NON_PRODUCTIVE**
    ///
    /// Unit: COUNT
    ///
    /// Name in real-time metrics report: [NPT (Non-Productive
    /// Time)](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#non-productive-time-real-time)
    ///
    /// **AGENTS_ON_CALL**
    ///
    /// Unit: COUNT
    ///
    /// Name in real-time metrics report: [On
    /// contact](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#on-call-real-time)
    ///
    /// **AGENTS_ON_CONTACT**
    ///
    /// Unit: COUNT
    ///
    /// Name in real-time metrics report: [On
    /// contact](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#on-call-real-time)
    ///
    /// **AGENTS_ONLINE**
    ///
    /// Unit: COUNT
    ///
    /// Name in real-time metrics report:
    /// [Online](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#online-real-time)
    ///
    /// **AGENTS_STAFFED**
    ///
    /// Unit: COUNT
    ///
    /// Name in real-time metrics report:
    /// [Staffed](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#staffed-real-time)
    ///
    /// **CONTACTS_IN_QUEUE**
    ///
    /// Unit: COUNT
    ///
    /// Name in real-time metrics report: [In
    /// queue](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#in-queue-real-time)
    ///
    /// **CONTACTS_SCHEDULED**
    ///
    /// Unit: COUNT
    ///
    /// Name in real-time metrics report:
    /// [Scheduled](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#scheduled-real-time)
    ///
    /// **ESTIMATED_WAIT_TIME**
    ///
    /// Unit: SECONDS
    ///
    /// This metric supports filter and grouping combination only used for core
    /// routing purpose.
    /// Valid filter and grouping use cases:
    ///
    /// * Filter by a list of [Queues] and a list of [Channels], group by [“QUEUE”,
    ///   “CHANNEL”]
    ///
    /// * Filter by a singleton list of [Queue], a singleton list of [Channel], a
    ///   list of [RoutingStepExpression], group by [“ROUTING_STEP_EXPRESSION”].
    ///
    /// **OLDEST_CONTACT_AGE**
    ///
    /// Unit: SECONDS
    ///
    /// When you use groupings, Unit says SECONDS and the Value is returned in
    /// SECONDS.
    ///
    /// When you do not use groupings, Unit says SECONDS but the Value is returned
    /// in MILLISECONDS. For example, if
    /// you get a response like this:
    ///
    /// `{ "Metric": { "Name": "OLDEST_CONTACT_AGE", "Unit": "SECONDS" }, "Value":
    /// 24113.0 `}
    ///
    /// The actual OLDEST_CONTACT_AGE is 24 seconds.
    ///
    /// When the filter `RoutingStepExpression` is used, this metric is still
    /// calculated from enqueue
    /// time. For example, if a contact that has been queued under `` for 10 seconds
    /// has
    /// expired and `` becomes active, then `OLDEST_CONTACT_AGE` for this queue
    /// will be counted starting from 10, not 0.
    ///
    /// Name in real-time metrics report:
    /// [Oldest](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#oldest-real-time)
    ///
    /// **SLOTS_ACTIVE**
    ///
    /// Unit: COUNT
    ///
    /// Name in real-time metrics report:
    /// [Active](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#active-real-time)
    ///
    /// **SLOTS_AVAILABLE**
    ///
    /// Unit: COUNT
    ///
    /// Name in real-time metrics report:
    /// [Availability](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html#availability-real-time)
    current_metrics: []const CurrentMetric,

    /// The filters to apply to returned metrics. You can filter up to the following
    /// limits:
    ///
    /// * Queues: 100
    ///
    /// * Routing profiles: 100
    ///
    /// * Channels: 3 (VOICE, CHAT, and TASK channels are supported.)
    ///
    /// * RoutingStepExpressions: 50
    ///
    /// * AgentStatuses: 50
    ///
    /// * Subtypes: 10
    ///
    /// * ValidationTestTypes: 10
    ///
    /// Metric data is retrieved only for the resources associated with the queues
    /// or routing profiles, and by any
    /// channels included in the filter. (You cannot filter by both queue AND
    /// routing profile.) You can include both resource
    /// IDs and resource ARNs in the same request.
    ///
    /// When using `AgentStatuses` as filter make sure Queues is added as primary
    /// filter.
    ///
    /// When using `Subtypes` as filter make sure Queues is added as primary filter.
    ///
    /// When using `ValidationTestTypes` as filter make sure Queues is added as
    /// primary filter.
    ///
    /// When using the `RoutingStepExpression` filter, you need to pass exactly one
    /// `QueueId`. The
    /// filter is also case sensitive so when using the `RoutingStepExpression`
    /// filter, grouping by
    /// `ROUTING_STEP_EXPRESSION` is required.
    ///
    /// Currently tagging is only supported on the resources that are passed in the
    /// filter.
    filters: Filters,

    /// Defines the level of aggregation for metrics data by a dimension(s). Its
    /// similar to sorting items into buckets
    /// based on a common characteristic, then counting or calculating something for
    /// each bucket. For example, when grouped
    /// by `QUEUE`, the metrics returned apply to each queue rather than aggregated
    /// for all queues.
    ///
    /// The grouping list is an ordered list, with the first item in the list
    /// defined as the primary grouping. If no
    /// grouping is included in the request, the aggregation happens at the
    /// instance-level.
    ///
    /// * If you group by `CHANNEL`, you should include a Channels filter. VOICE,
    ///   CHAT, and TASK channels are supported.
    ///
    /// * If you group by `AGENT_STATUS`, you must include the `QUEUE` as the
    ///   primary grouping and
    /// use queue filter. When you group by `AGENT_STATUS`, the only metric
    /// available is the
    /// `AGENTS_ONLINE` metric.
    ///
    /// * If you group by `SUBTYPE` or `VALIDATION_TEST_TYPE` as secondary grouping
    ///   then you must include `QUEUE` as
    /// primary grouping and use Queue as filter
    ///
    /// * If you group by `ROUTING_PROFILE`, you must include either a queue or
    ///   routing profile filter. In
    /// addition, a routing profile filter is required for metrics
    /// `CONTACTS_SCHEDULED`,
    /// `CONTACTS_IN_QUEUE`, and ` OLDEST_CONTACT_AGE`.
    ///
    /// * When using the `RoutingStepExpression` filter, group by
    ///   `ROUTING_STEP_EXPRESSION` is
    /// required.
    groupings: ?[]const Grouping = null,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    ///
    /// The token expires after 5 minutes from the time it is created. Subsequent
    /// requests that use
    /// the token must use the same request parameters as the request that generated
    /// the token.
    next_token: ?[]const u8 = null,

    /// The way to sort the resulting response based on metrics. You can enter one
    /// sort criteria. By default resources
    /// are sorted based on `AGENTS_ONLINE`, `DESCENDING`. The metric collection is
    /// sorted based on the
    /// input metrics.
    ///
    /// Note the following:
    ///
    /// * Sorting on `SLOTS_ACTIVE` and `SLOTS_AVAILABLE` is not supported.
    sort_criteria: ?[]const CurrentMetricSortCriteria = null,

    pub const json_field_names = .{
        .current_metrics = "CurrentMetrics",
        .filters = "Filters",
        .groupings = "Groupings",
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_criteria = "SortCriteria",
    };
};

pub const GetCurrentMetricDataOutput = struct {
    /// The total count of the result, regardless of the current page size.
    approximate_total_count: ?i64 = null,

    /// The time at which the metrics were retrieved and cached for pagination.
    data_snapshot_time: ?i64 = null,

    /// Information about the real-time metrics.
    metric_results: ?[]const CurrentMetricResult = null,

    /// If there are additional results, this is the token for the next set of
    /// results.
    ///
    /// The token expires after 5 minutes from the time it is created. Subsequent
    /// requests that use
    /// the token must use the same request parameters as the request that generated
    /// the token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .approximate_total_count = "ApproximateTotalCount",
        .data_snapshot_time = "DataSnapshotTime",
        .metric_results = "MetricResults",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCurrentMetricDataInput, options: CallOptions) !GetCurrentMetricDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCurrentMetricDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/metrics/current/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CurrentMetrics\":");
    try aws.json.writeValue(@TypeOf(input.current_metrics), input.current_metrics, allocator, &body_buf);
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
    if (input.sort_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SortCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCurrentMetricDataOutput {
    var result: GetCurrentMetricDataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCurrentMetricDataOutput, body, allocator);
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
