const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountFindingsMetric = @import("account_findings_metric.zig").AccountFindingsMetric;

pub const ListFindingsMetricsInput = struct {
    /// The end date of the interval which you want to retrieve metrics from. Round
    /// to the nearest day.
    end_date: i64,

    /// The maximum number of results to return in the response. Use this parameter
    /// when paginating results. If additional results exist beyond the number you
    /// specify, the `nextToken` element is returned in the response. Use
    /// `nextToken` in a subsequent request to retrieve additional results. If not
    /// specified, returns 1000 results.
    max_results: ?i32 = null,

    /// A token to use for paginating results that are returned in the response. Set
    /// the value of this parameter to null for the first request. For subsequent
    /// calls, use the `nextToken` value returned from the previous request to
    /// continue listing results after the first page.
    next_token: ?[]const u8 = null,

    /// The start date of the interval which you want to retrieve metrics from.
    /// Rounds to the nearest day.
    start_date: i64,

    pub const json_field_names = .{
        .end_date = "endDate",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .start_date = "startDate",
    };
};

pub const ListFindingsMetricsOutput = struct {
    /// A list of `AccountFindingsMetric` objects retrieved from the specified time
    /// interval.
    findings_metrics: ?[]const AccountFindingsMetric = null,

    /// A pagination token. You can use this in future calls to `ListFindingMetrics`
    /// to continue listing results after the current page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .findings_metrics = "findingsMetrics",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFindingsMetricsInput, options: CallOptions) !ListFindingsMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-security", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFindingsMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-security", "CodeGuru Security", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/metrics/findings";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "endDate=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.end_date}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "startDate=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.start_date}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFindingsMetricsOutput {
    var result: ListFindingsMetricsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListFindingsMetricsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
