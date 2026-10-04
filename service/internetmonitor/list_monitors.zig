const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Monitor = @import("monitor.zig").Monitor;

pub const ListMonitorsInput = struct {
    /// A boolean option that you can set to `TRUE` to include monitors for linked
    /// accounts in a list of
    /// monitors, when you've set up cross-account sharing in Amazon CloudWatch
    /// Internet Monitor. You configure cross-account
    /// sharing by using Amazon CloudWatch Observability Access Manager. For more
    /// information, see
    /// [Internet Monitor cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cwim-cross-account.html) in the Amazon CloudWatch Internet Monitor User Guide.
    include_linked_accounts: ?bool = null,

    /// The number of monitor objects that you want to return with this call.
    max_results: ?i32 = null,

    /// The status of a monitor. This includes the status of the data processing for
    /// the monitor and the status of the monitor itself.
    ///
    /// For information about the statuses for a monitor, see [
    /// Monitor](https://docs.aws.amazon.com/internet-monitor/latest/api/API_Monitor.html).
    monitor_status: ?[]const u8 = null,

    /// The token for the next set of results. You receive this token from a
    /// previous call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .include_linked_accounts = "IncludeLinkedAccounts",
        .max_results = "MaxResults",
        .monitor_status = "MonitorStatus",
        .next_token = "NextToken",
    };
};

pub const ListMonitorsOutput = struct {
    /// A list of monitors.
    monitors: ?[]const Monitor = null,

    /// The token for the next set of results. You receive this token from a
    /// previous call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .monitors = "Monitors",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMonitorsInput, options: CallOptions) !ListMonitorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMonitorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("internetmonitor", "InternetMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20210603/Monitors";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_linked_accounts) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "IncludeLinkedAccounts=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.monitor_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MonitorStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMonitorsOutput {
    const result: ListMonitorsOutput = try aws.json.parseJsonObject(
        ListMonitorsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
