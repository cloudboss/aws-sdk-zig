const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DestinationCategory = @import("destination_category.zig").DestinationCategory;
const WorkloadInsightsMetric = @import("workload_insights_metric.zig").WorkloadInsightsMetric;

pub const StartQueryWorkloadInsightsTopContributorsInput = struct {
    /// The destination category for a top contributors row. Destination categories
    /// can be one of the following:
    ///
    /// * `INTRA_AZ`: Top contributor network flows within a single Availability
    ///   Zone
    /// * `INTER_AZ`: Top contributor network flows between Availability Zones
    /// * `INTER_REGION`: Top contributor network flows between Regions (to the edge
    ///   of another Region)
    /// * `INTER_VPC`: Top contributor network flows between VPCs
    /// * `AWS_SERVICES`: Top contributor network flows to or from Amazon Web
    ///   Services services
    /// * `UNCLASSIFIED`: Top contributor network flows that do not have a bucket
    ///   classification
    destination_category: DestinationCategory,

    /// The timestamp that is the date and time end of the period that you want to
    /// retrieve results for with your query.
    end_time: i64,

    /// The maximum number of top contributors to return.
    limit: ?i32 = null,

    /// The metric that you want to query top contributors for. That is, you can
    /// specify this metric to return the top contributor network flows, for this
    /// type of metric, for a monitor and (optionally) within a specific category,
    /// such as network flows between Availability Zones.
    metric_name: WorkloadInsightsMetric,

    /// The identifier for the scope that includes the resources you want to get
    /// data results for. A scope ID is an internally-generated identifier that
    /// includes all the resources for a specific root account. A scope ID is
    /// returned from a `CreateScope` API call.
    scope_id: []const u8,

    /// The timestamp that is the date and time that is the beginning of the period
    /// that you want to retrieve results for with your query.
    start_time: i64,

    pub const json_field_names = .{
        .destination_category = "destinationCategory",
        .end_time = "endTime",
        .limit = "limit",
        .metric_name = "metricName",
        .scope_id = "scopeId",
        .start_time = "startTime",
    };
};

pub const StartQueryWorkloadInsightsTopContributorsOutput = struct {
    /// The identifier for the query. A query ID is an internally-generated
    /// identifier for a specific query returned from an API call to start a query.
    query_id: []const u8,

    pub const json_field_names = .{
        .query_id = "queryId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartQueryWorkloadInsightsTopContributorsInput, options: Options) !StartQueryWorkloadInsightsTopContributorsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "networkflowmonitor");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartQueryWorkloadInsightsTopContributorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkflowmonitor", "NetworkFlowMonitor", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/workloadInsights/");
    try path_buf.appendSlice(allocator, input.scope_id);
    try path_buf.appendSlice(allocator, "/topContributorsQueries");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationCategory\":");
    try aws.json.writeValue(@TypeOf(input.destination_category), input.destination_category, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"endTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, allocator, &body_buf);
    has_prev = true;
    if (input.limit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"limit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"metricName\":");
    try aws.json.writeValue(@TypeOf(input.metric_name), input.metric_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"startTime\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartQueryWorkloadInsightsTopContributorsOutput {
    var result: StartQueryWorkloadInsightsTopContributorsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartQueryWorkloadInsightsTopContributorsOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
