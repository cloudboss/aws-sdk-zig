const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventType = @import("event_type.zig").EventType;

pub const GetNotificationConfigurationInput = struct {
    /// The type of event triggering a device notification to the customer-managed
    /// destination.
    event_type: EventType,

    pub const json_field_names = .{
        .event_type = "EventType",
    };
};

pub const GetNotificationConfigurationOutput = struct {
    /// The timestamp value of when the notification configuration was created.
    created_at: ?i64 = null,

    /// The name of the destination for the notification configuration.
    destination_name: ?[]const u8 = null,

    /// The type of event triggering a device notification to the customer-managed
    /// destination.
    event_type: ?EventType = null,

    /// A set of key/value pairs that are used to manage the notification
    /// configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp value of when the notification configuration was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .destination_name = "DestinationName",
        .event_type = "EventType",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNotificationConfigurationInput, options: CallOptions) !GetNotificationConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNotificationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/notification-configurations/");
    try path_buf.appendSlice(allocator, input.event_type);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetNotificationConfigurationOutput {
    var result: GetNotificationConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetNotificationConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
