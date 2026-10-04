const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventConfig = @import("event_config.zig").EventConfig;
const Api = @import("api.zig").Api;

pub const CreateApiInput = struct {
    /// The Event API configuration. This includes the default authorization
    /// configuration for
    /// connecting, publishing, and subscribing to an Event API.
    event_config: EventConfig,

    /// The name for the `Api`.
    name: []const u8,

    /// The owner contact information for the `Api`.
    owner_contact: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .event_config = "eventConfig",
        .name = "name",
        .owner_contact = "ownerContact",
        .tags = "tags",
    };
};

pub const CreateApiOutput = struct {
    /// The `Api` object.
    api: ?Api = null,

    pub const json_field_names = .{
        .api = "api",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApiInput, options: CallOptions) !CreateApiOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appsync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApiInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/apis";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"eventConfig\":");
    try aws.json.writeValue(@TypeOf(input.event_config), input.event_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.owner_contact) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ownerContact\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApiOutput {
    var result: CreateApiOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateApiOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
