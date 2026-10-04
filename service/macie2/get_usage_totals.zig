const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimeRange = @import("time_range.zig").TimeRange;
const UsageTotal = @import("usage_total.zig").UsageTotal;

pub const GetUsageTotalsInput = struct {
    /// The inclusive time period to retrieve the data for. Valid values are:
    /// MONTH_TO_DATE, for the current calendar month to date; and, PAST_30_DAYS,
    /// for the preceding 30 days. If you don't specify a value for this parameter,
    /// Amazon Macie provides aggregated usage data for the preceding 30 days.
    time_range: ?[]const u8 = null,

    pub const json_field_names = .{
        .time_range = "timeRange",
    };
};

pub const GetUsageTotalsOutput = struct {
    /// The inclusive time period that the usage data applies to. Possible values
    /// are: MONTH_TO_DATE, for the current calendar month to date; and,
    /// PAST_30_DAYS, for the preceding 30 days.
    time_range: ?TimeRange = null,

    /// An array of objects that contains the results of the query. Each object
    /// contains the data for a specific usage metric.
    usage_totals: ?[]const UsageTotal = null,

    pub const json_field_names = .{
        .time_range = "timeRange",
        .usage_totals = "usageTotals",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUsageTotalsInput, options: CallOptions) !GetUsageTotalsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUsageTotalsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/usage";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.time_range) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "timeRange=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUsageTotalsOutput {
    const result: GetUsageTotalsOutput = try aws.json.parseJsonObject(
        GetUsageTotalsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
