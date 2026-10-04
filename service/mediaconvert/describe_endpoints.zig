const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DescribeEndpointsMode = @import("describe_endpoints_mode.zig").DescribeEndpointsMode;
const Endpoint = @import("endpoint.zig").Endpoint;

pub const DescribeEndpointsInput = struct {
    /// Optional. Max number of endpoints, up to twenty, that will be returned at
    /// one time.
    max_results: ?i32 = null,

    /// Optional field, defaults to DEFAULT. Specify DEFAULT for this operation to
    /// return your endpoints if any exist, or to create an endpoint for you and
    /// return it if one doesn't already exist. Specify GET_ONLY to return your
    /// endpoints if any exist, or an empty list if none exist.
    mode: ?DescribeEndpointsMode = null,

    /// Use this string, provided with the response to a previous request, to
    /// request the next batch of endpoints.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .mode = "Mode",
        .next_token = "NextToken",
    };
};

pub const DescribeEndpointsOutput = struct {
    /// List of endpoints
    endpoints: ?[]const Endpoint = null,

    /// Use this string to request the next batch of endpoints.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoints = "Endpoints",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEndpointsInput, options: CallOptions) !DescribeEndpointsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconvert", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEndpointsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconvert", "MediaConvert", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2017-08-29/endpoints";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Mode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEndpointsOutput {
    var result: DescribeEndpointsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeEndpointsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
