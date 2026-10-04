const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RemovePermissionInput = struct {
    /// The name of the event bus to revoke permissions for. If you omit this, the
    /// default event
    /// bus is used.
    event_bus_name: ?[]const u8 = null,

    /// Specifies whether to remove all permissions.
    remove_all_permissions: ?bool = null,

    /// The statement ID corresponding to the account that is no longer allowed to
    /// put events to
    /// the default event bus.
    statement_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_bus_name = "EventBusName",
        .remove_all_permissions = "RemoveAllPermissions",
        .statement_id = "StatementId",
    };
};

pub const RemovePermissionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RemovePermissionInput, options: CallOptions) !RemovePermissionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RemovePermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "EventBridge", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.RemovePermission");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RemovePermissionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
