const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InsightEntity = @import("insight_entity.zig").InsightEntity;
const InsightSortOrder = @import("insight_sort_order.zig").InsightSortOrder;
const InsightTimeRange = @import("insight_time_range.zig").InsightTimeRange;
const Insight = @import("insight.zig").Insight;

pub const ListInsightsInput = struct {
    /// The entity for which to list insights. Specifies the type and value of the
    /// entity,
    /// such as a domain name or Amazon Web Services account ID.
    entity: InsightEntity,

    /// An optional parameter that specifies the maximum number of results to
    /// return. You can
    /// use `NextToken` to get the next page of results. Valid values are 1 to
    /// 500.
    max_results: ?i32 = null,

    /// If your initial `ListInsights` operation returns a
    /// `NextToken`, include the returned `NextToken` in subsequent
    /// `ListInsights` operations to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// The sort order for the results. Possible values are `ASC` (ascending) and
    /// `DESC` (descending).
    sort_order: ?InsightSortOrder = null,

    /// The time range for filtering insights, specified as epoch millisecond
    /// timestamps.
    time_range: ?InsightTimeRange = null,

    pub const json_field_names = .{
        .entity = "Entity",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_order = "SortOrder",
        .time_range = "TimeRange",
    };
};

pub const ListInsightsOutput = struct {
    /// The list of insights returned for the specified entity.
    insights: ?[]const Insight = null,

    /// When `NextToken` is returned, there are more results available. The value
    /// of `NextToken` is a unique pagination token for each page. Send the request
    /// again using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .insights = "Insights",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInsightsInput, options: CallOptions) !ListInsightsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInsightsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/opensearch/insights";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Entity\":");
    try aws.json.writeValue(@TypeOf(input.entity), input.entity, allocator, &body_buf);
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
    if (input.sort_order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SortOrder\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.time_range) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TimeRange\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInsightsOutput {
    const result: ListInsightsOutput = try aws.json.parseJsonObject(
        ListInsightsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
