const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DiscovererState = @import("discoverer_state.zig").DiscovererState;

pub const CreateDiscovererInput = struct {
    /// Support discovery of schemas in events sent to the bus from another account.
    /// (default: true).
    cross_account: ?bool = null,

    /// A description for the discoverer.
    description: ?[]const u8 = null,

    /// The ARN of the event bus.
    source_arn: []const u8,

    /// Tags associated with the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cross_account = "CrossAccount",
        .description = "Description",
        .source_arn = "SourceArn",
        .tags = "Tags",
    };
};

pub const CreateDiscovererOutput = struct {
    /// The Status if the discoverer will discover schemas from events sent from
    /// another account.
    cross_account: ?bool = null,

    /// The description of the discoverer.
    description: ?[]const u8 = null,

    /// The ARN of the discoverer.
    discoverer_arn: ?[]const u8 = null,

    /// The ID of the discoverer.
    discoverer_id: ?[]const u8 = null,

    /// The ARN of the event bus.
    source_arn: ?[]const u8 = null,

    /// The state of the discoverer.
    state: ?DiscovererState = null,

    /// Tags associated with the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cross_account = "CrossAccount",
        .description = "Description",
        .discoverer_arn = "DiscovererArn",
        .discoverer_id = "DiscovererId",
        .source_arn = "SourceArn",
        .state = "State",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDiscovererInput, options: CallOptions) !CreateDiscovererOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "schemas", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDiscovererInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("schemas", "schemas", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/discoverers";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cross_account) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CrossAccount\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SourceArn\":");
    try aws.json.writeValue(@TypeOf(input.source_arn), input.source_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDiscovererOutput {
    const result: CreateDiscovererOutput = try aws.json.parseJsonObject(
        CreateDiscovererOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
