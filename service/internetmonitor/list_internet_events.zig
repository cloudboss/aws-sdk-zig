const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InternetEventSummary = @import("internet_event_summary.zig").InternetEventSummary;

pub const ListInternetEventsInput = struct {
    /// The end time of the time window that you want to get a list of internet
    /// events for.
    end_time: ?i64 = null,

    /// The status of an internet event.
    event_status: ?[]const u8 = null,

    /// The type of network impairment.
    event_type: ?[]const u8 = null,

    /// The number of query results that you want to return with this call.
    max_results: ?i32 = null,

    /// The token for the next set of results. You receive this token from a
    /// previous call.
    next_token: ?[]const u8 = null,

    /// The start time of the time window that you want to get a list of internet
    /// events for.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .event_status = "EventStatus",
        .event_type = "EventType",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .start_time = "StartTime",
    };
};

pub const ListInternetEventsOutput = struct {
    /// A set of internet events returned for the list operation.
    internet_events: ?[]const InternetEventSummary = null,

    /// The token for the next set of results. You receive this token from a
    /// previous call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .internet_events = "InternetEvents",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInternetEventsInput, options: CallOptions) !ListInternetEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "internetmonitor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInternetEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("internetmonitor", "InternetMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20210603/InternetEvents";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.end_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "EndTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.event_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "EventStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.event_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "EventType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "InternetEventMaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.start_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "StartTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInternetEventsOutput {
    var result: ListInternetEventsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListInternetEventsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
