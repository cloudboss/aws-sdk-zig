const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryFilter = @import("query_filter.zig").QueryFilter;
const TimeRange = @import("time_range.zig").TimeRange;

pub const GetAppMonitorDataInput = struct {
    /// An array of structures that you can use to filter the results to those that
    /// match one or more sets of key-value pairs that you specify.
    filters: ?[]const QueryFilter = null,

    /// The maximum number of results to return in one operation.
    max_results: ?i32 = null,

    /// The name of the app monitor that collected the data that you want to
    /// retrieve.
    name: []const u8,

    /// Use the token returned by the previous operation to request the next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// A structure that defines the time range that you want to retrieve results
    /// from.
    time_range: TimeRange,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .name = "Name",
        .next_token = "NextToken",
        .time_range = "TimeRange",
    };
};

pub const GetAppMonitorDataOutput = struct {
    /// The events that RUM collected that match your request.
    events: ?[]const []const u8 = null,

    /// A token that you can use in a subsequent operation to retrieve the next set
    /// of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "Events",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAppMonitorDataInput, options: CallOptions) !GetAppMonitorDataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAppMonitorDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rum", "RUM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/appmonitor/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/data");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TimeRange\":");
    try aws.json.writeValue(@TypeOf(input.time_range), input.time_range, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAppMonitorDataOutput {
    var result: GetAppMonitorDataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAppMonitorDataOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
