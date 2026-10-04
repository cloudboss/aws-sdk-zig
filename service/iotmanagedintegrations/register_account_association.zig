const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RegisterAccountAssociationInput = struct {
    /// The identifier of the account association to register with the managed
    /// thing.
    account_association_id: []const u8,

    /// The identifier of the device discovery job associated with this
    /// registration.
    device_discovery_id: []const u8,

    /// The identifier of the managed thing to register with the account
    /// association.
    managed_thing_id: []const u8,

    pub const json_field_names = .{
        .account_association_id = "AccountAssociationId",
        .device_discovery_id = "DeviceDiscoveryId",
        .managed_thing_id = "ManagedThingId",
    };
};

pub const RegisterAccountAssociationOutput = struct {
    /// The identifier of the account association that was registered.
    account_association_id: ?[]const u8 = null,

    /// The identifier of the device discovery job associated with this
    /// registration.
    device_discovery_id: ?[]const u8 = null,

    /// The identifier of the managed thing that was registered with the account
    /// association.
    managed_thing_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_association_id = "AccountAssociationId",
        .device_discovery_id = "DeviceDiscoveryId",
        .managed_thing_id = "ManagedThingId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterAccountAssociationInput, options: CallOptions) !RegisterAccountAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterAccountAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/managed-thing-associations/register";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AccountAssociationId\":");
    try aws.json.writeValue(@TypeOf(input.account_association_id), input.account_association_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DeviceDiscoveryId\":");
    try aws.json.writeValue(@TypeOf(input.device_discovery_id), input.device_discovery_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ManagedThingId\":");
    try aws.json.writeValue(@TypeOf(input.managed_thing_id), input.managed_thing_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterAccountAssociationOutput {
    var result: RegisterAccountAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterAccountAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
