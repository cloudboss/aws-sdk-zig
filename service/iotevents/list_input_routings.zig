const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputIdentifier = @import("input_identifier.zig").InputIdentifier;
const RoutedResource = @import("routed_resource.zig").RoutedResource;

pub const ListInputRoutingsInput = struct {
    /// The identifer of the routed input.
    input_identifier: InputIdentifier,

    /// The maximum number of results to be returned per request.
    max_results: ?i32 = null,

    /// The token that you can use to return the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .input_identifier = "inputIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListInputRoutingsOutput = struct {
    /// The token that you can use to return the next set of results,
    /// or `null` if there are no more results.
    next_token: ?[]const u8 = null,

    /// Summary information about the routed resources.
    routed_resources: ?[]const RoutedResource = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .routed_resources = "routedResources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInputRoutingsInput, options: CallOptions) !ListInputRoutingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotevents", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInputRoutingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotevents", "IoT Events", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/input-routings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"inputIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.input_identifier), input.input_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInputRoutingsOutput {
    var result: ListInputRoutingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListInputRoutingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
