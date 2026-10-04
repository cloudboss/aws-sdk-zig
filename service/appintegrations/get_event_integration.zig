const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventFilter = @import("event_filter.zig").EventFilter;

pub const GetEventIntegrationInput = struct {
    /// The name of the event integration.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const GetEventIntegrationOutput = struct {
    /// The description of the event integration.
    description: ?[]const u8 = null,

    /// The EventBridge bus.
    event_bridge_bus: ?[]const u8 = null,

    /// The event filter.
    event_filter: ?EventFilter = null,

    /// The Amazon Resource Name (ARN) for the event integration.
    event_integration_arn: ?[]const u8 = null,

    /// The name of the event integration.
    name: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .event_bridge_bus = "EventBridgeBus",
        .event_filter = "EventFilter",
        .event_integration_arn = "EventIntegrationArn",
        .name = "Name",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEventIntegrationInput, options: CallOptions) !GetEventIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "app-integrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEventIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("app-integrations", "AppIntegrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/eventIntegrations/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEventIntegrationOutput {
    const result: GetEventIntegrationOutput = try aws.json.parseJsonObject(
        GetEventIntegrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
