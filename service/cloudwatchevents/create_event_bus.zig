const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateEventBusInput = struct {
    /// If you are creating a partner event bus, this specifies the partner event
    /// source that the
    /// new event bus will be matched with.
    event_source_name: ?[]const u8 = null,

    /// The name of the new event bus.
    ///
    /// Event bus names cannot contain the / character. You can't use the name
    /// `default` for a custom event bus, as this name is already used for your
    /// account's
    /// default event bus.
    ///
    /// If this is a partner event bus, the name must exactly match the name of the
    /// partner event
    /// source that this event bus is matched to.
    name: []const u8,

    /// Tags to associate with the event bus.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .event_source_name = "EventSourceName",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateEventBusOutput = struct {
    /// The ARN of the new event bus.
    event_bus_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_bus_arn = "EventBusArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEventBusInput, options: CallOptions) !CreateEventBusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "events", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEventBusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "CloudWatch Events", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.CreateEventBus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEventBusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEventBusOutput, body, allocator);
}
