const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricDestinationSummary = @import("metric_destination_summary.zig").MetricDestinationSummary;

pub const ListRumMetricsDestinationsInput = struct {
    /// The name of the app monitor associated with the destinations that you want
    /// to retrieve.
    app_monitor_name: []const u8,

    /// The maximum number of results to return in one operation. The default is 50.
    /// The maximum that you can specify is 100.
    ///
    /// To retrieve the remaining results, make another call with the returned
    /// `NextToken` value.
    max_results: ?i32 = null,

    /// Use the token returned by the previous operation to request the next page of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_monitor_name = "AppMonitorName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListRumMetricsDestinationsOutput = struct {
    /// The list of CloudWatch RUM extended metrics destinations associated with the
    /// app monitor that you specified.
    destinations: ?[]const MetricDestinationSummary = null,

    /// A token that you can use in a subsequent operation to retrieve the next set
    /// of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .destinations = "Destinations",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRumMetricsDestinationsInput, options: CallOptions) !ListRumMetricsDestinationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rum", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRumMetricsDestinationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rum", "RUM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/rummetrics/");
    try path_buf.appendSlice(allocator, input.app_monitor_name);
    try path_buf.appendSlice(allocator, "/metricsdestination");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRumMetricsDestinationsOutput {
    var result: ListRumMetricsDestinationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRumMetricsDestinationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
