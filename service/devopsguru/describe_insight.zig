const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProactiveInsight = @import("proactive_insight.zig").ProactiveInsight;
const ReactiveInsight = @import("reactive_insight.zig").ReactiveInsight;

pub const DescribeInsightInput = struct {
    /// The ID of the member account in the organization.
    account_id: ?[]const u8 = null,

    /// The ID of the insight.
    id: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .id = "Id",
    };
};

pub const DescribeInsightOutput = struct {
    /// A `ProactiveInsight` object that represents the requested insight.
    proactive_insight: ?ProactiveInsight = null,

    /// A `ReactiveInsight` object that represents the requested insight.
    reactive_insight: ?ReactiveInsight = null,

    pub const json_field_names = .{
        .proactive_insight = "ProactiveInsight",
        .reactive_insight = "ReactiveInsight",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInsightInput, options: CallOptions) !DescribeInsightOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devops-guru", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInsightInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devops-guru", "DevOps Guru", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/insights/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "AccountId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInsightOutput {
    const result: DescribeInsightOutput = try aws.json.parseJsonObject(
        DescribeInsightOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
