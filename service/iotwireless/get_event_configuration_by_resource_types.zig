const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionStatusResourceTypeEventConfiguration = @import("connection_status_resource_type_event_configuration.zig").ConnectionStatusResourceTypeEventConfiguration;
const DeviceRegistrationStateResourceTypeEventConfiguration = @import("device_registration_state_resource_type_event_configuration.zig").DeviceRegistrationStateResourceTypeEventConfiguration;
const JoinResourceTypeEventConfiguration = @import("join_resource_type_event_configuration.zig").JoinResourceTypeEventConfiguration;
const MessageDeliveryStatusResourceTypeEventConfiguration = @import("message_delivery_status_resource_type_event_configuration.zig").MessageDeliveryStatusResourceTypeEventConfiguration;
const ProximityResourceTypeEventConfiguration = @import("proximity_resource_type_event_configuration.zig").ProximityResourceTypeEventConfiguration;

pub const GetEventConfigurationByResourceTypesInput = struct {
};

pub const GetEventConfigurationByResourceTypesOutput = struct {
    /// Resource type event configuration for the connection status event.
    connection_status: ?ConnectionStatusResourceTypeEventConfiguration = null,

    /// Resource type event configuration for the device registration state event.
    device_registration_state: ?DeviceRegistrationStateResourceTypeEventConfiguration = null,

    /// Resource type event configuration for the join event.
    join: ?JoinResourceTypeEventConfiguration = null,

    /// Resource type event configuration object for the message delivery status
    /// event.
    message_delivery_status: ?MessageDeliveryStatusResourceTypeEventConfiguration = null,

    /// Resource type event configuration for the proximity event.
    proximity: ?ProximityResourceTypeEventConfiguration = null,

    pub const json_field_names = .{
        .connection_status = "ConnectionStatus",
        .device_registration_state = "DeviceRegistrationState",
        .join = "Join",
        .message_delivery_status = "MessageDeliveryStatus",
        .proximity = "Proximity",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEventConfigurationByResourceTypesInput, options: CallOptions) !GetEventConfigurationByResourceTypesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEventConfigurationByResourceTypesInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/event-configurations-resource-types";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEventConfigurationByResourceTypesOutput {
    var result: GetEventConfigurationByResourceTypesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEventConfigurationByResourceTypesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
