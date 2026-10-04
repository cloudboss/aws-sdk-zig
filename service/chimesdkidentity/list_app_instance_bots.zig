const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppInstanceBotSummary = @import("app_instance_bot_summary.zig").AppInstanceBotSummary;

pub const ListAppInstanceBotsInput = struct {
    /// The ARN of the `AppInstance`.
    app_instance_arn: []const u8,

    /// The maximum number of requests to return.
    max_results: ?i32 = null,

    /// The token passed by previous API calls until all requested bots are
    /// returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_instance_arn = "AppInstanceArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListAppInstanceBotsOutput = struct {
    /// The ARN of the AppInstance.
    app_instance_arn: ?[]const u8 = null,

    /// The information for each requested `AppInstanceBot`.
    app_instance_bots: ?[]const AppInstanceBotSummary = null,

    /// The token passed by previous API calls until all requested bots are
    /// returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_instance_arn = "AppInstanceArn",
        .app_instance_bots = "AppInstanceBots",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAppInstanceBotsInput, options: CallOptions) !ListAppInstanceBotsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAppInstanceBotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("identity-chime", "Chime SDK Identity", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/app-instance-bots";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "app-instance-arn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.app_instance_arn);
    query_has_prev = true;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-results=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next-token=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAppInstanceBotsOutput {
    const result: ListAppInstanceBotsOutput = try aws.json.parseJsonObject(
        ListAppInstanceBotsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
