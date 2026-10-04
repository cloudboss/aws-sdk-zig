const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StateEndpoint = @import("state_endpoint.zig").StateEndpoint;

pub const GetManagedThingStateInput = struct {
    /// The id of the device.
    managed_thing_id: []const u8,

    pub const json_field_names = .{
        .managed_thing_id = "ManagedThingId",
    };
};

pub const GetManagedThingStateOutput = struct {
    /// The device endpoint.
    endpoints: ?[]const StateEndpoint = null,

    pub const json_field_names = .{
        .endpoints = "Endpoints",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetManagedThingStateInput, options: CallOptions) !GetManagedThingStateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetManagedThingStateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/managed-thing-states/");
    try path_buf.appendSlice(allocator, input.managed_thing_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetManagedThingStateOutput {
    var result: GetManagedThingStateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetManagedThingStateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
