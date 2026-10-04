const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationCategory = @import("destination_category.zig").DestinationCategory;
const MonitorMetric = @import("monitor_metric.zig").MonitorMetric;

pub const StartQueryMonitorTopContributorsInput = struct {
    /// The category that you want to query top contributors for, for a specific
    /// monitor. Destination categories can be one of the following:
    ///
    /// * `INTRA_AZ`: Top contributor network flows within a single Availability
    ///   Zone
    /// * `INTER_AZ`: Top contributor network flows between Availability Zones
    /// * `INTER_REGION`: Top contributor network flows between Regions (to the edge
    ///   of another Region)
    /// * `INTER_VPC`: Top contributor network flows between VPCs
    /// * `AMAZON_S3`: Top contributor network flows to or from Amazon S3
    /// * `AMAZON_DYNAMODB`: Top contributor network flows to or from Amazon Dynamo
    ///   DB
    /// * `UNCLASSIFIED`: Top contributor network flows that do not have a bucket
    ///   classification
    destination_category: DestinationCategory,

    /// The timestamp that is the date and time end of the period that you want to
    /// retrieve results for with your query.
    end_time: i64,

    /// The maximum number of top contributors to return.
    limit: ?i32 = null,

    /// The metric that you want to query top contributors for. That is, you can
    /// specify a metric with this call and return the top contributor network
    /// flows, for that type of metric, for a monitor and (optionally) within a
    /// specific category, such as network flows between Availability Zones.
    metric_name: MonitorMetric,

    /// The name of the monitor.
    monitor_name: []const u8,

    /// The timestamp that is the date and time that is the beginning of the period
    /// that you want to retrieve results for with your query.
    start_time: i64,

    pub const json_field_names = .{
        .destination_category = "destinationCategory",
        .end_time = "endTime",
        .limit = "limit",
        .metric_name = "metricName",
        .monitor_name = "monitorName",
        .start_time = "startTime",
    };
};

pub const StartQueryMonitorTopContributorsOutput = struct {
    /// The identifier for the query. A query ID is an internally-generated
    /// identifier for a specific query returned from an API call to start a query.
    query_id: []const u8,

    pub const json_field_names = .{
        .query_id = "queryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartQueryMonitorTopContributorsInput, options: CallOptions) !StartQueryMonitorTopContributorsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkflowmonitor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartQueryMonitorTopContributorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkflowmonitor", "NetworkFlowMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/monitors/");
    try path_buf.appendSlice(allocator, input.monitor_name);
    try path_buf.appendSlice(allocator, "/topContributorsQueries");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartQueryMonitorTopContributorsOutput {
    const result: StartQueryMonitorTopContributorsOutput = try aws.json.parseJsonObject(
        StartQueryMonitorTopContributorsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
