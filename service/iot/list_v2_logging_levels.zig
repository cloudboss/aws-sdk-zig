const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogTargetType = @import("log_target_type.zig").LogTargetType;
const LogTargetConfiguration = @import("log_target_configuration.zig").LogTargetConfiguration;

pub const ListV2LoggingLevelsInput = struct {
    /// The maximum number of results to return at one time.
    max_results: ?i32 = null,

    /// To retrieve the next set of results, the `nextToken`
    /// value from a previous response; otherwise **null** to receive
    /// the first set of results.
    next_token: ?[]const u8 = null,

    /// The type of resource for which you are configuring logging. Must be
    /// `DEFAULT`, `THING_GROUP`, `CLIENT_ID`,
    /// `SOURCE_IP`, or `PRINCIPAL_ID`.
    target_type: ?LogTargetType = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .target_type = "targetType",
    };
};

pub const ListV2LoggingLevelsOutput = struct {
    /// The logging configuration for a target.
    log_target_configurations: ?[]const LogTargetConfiguration = null,

    /// The token to use to get the next set of results, or **null** if there are no
    /// additional results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_target_configurations = "logTargetConfigurations",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListV2LoggingLevelsInput, options: CallOptions) !ListV2LoggingLevelsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListV2LoggingLevelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2LoggingLevel";

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
    if (input.target_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "targetType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListV2LoggingLevelsOutput {
    const result: ListV2LoggingLevelsOutput = try aws.json.parseJsonObject(
        ListV2LoggingLevelsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
