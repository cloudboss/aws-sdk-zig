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

pub const UpdateEventConfigurationByResourceTypesInput = struct {
    /// Connection status resource type event configuration object for enabling and
    /// disabling
    /// wireless gateway topic.
    connection_status: ?ConnectionStatusResourceTypeEventConfiguration = null,

    /// Device registration state resource type event configuration object for
    /// enabling and
    /// disabling wireless gateway topic.
    device_registration_state: ?DeviceRegistrationStateResourceTypeEventConfiguration = null,

    /// Join resource type event configuration object for enabling and disabling
    /// wireless
    /// device topic.
    join: ?JoinResourceTypeEventConfiguration = null,

    /// Message delivery status resource type event configuration object for
    /// enabling and
    /// disabling wireless device topic.
    message_delivery_status: ?MessageDeliveryStatusResourceTypeEventConfiguration = null,

    /// Proximity resource type event configuration object for enabling and
    /// disabling wireless
    /// gateway topic.
    proximity: ?ProximityResourceTypeEventConfiguration = null,

    pub const json_field_names = .{
        .connection_status = "ConnectionStatus",
        .device_registration_state = "DeviceRegistrationState",
        .join = "Join",
        .message_delivery_status = "MessageDeliveryStatus",
        .proximity = "Proximity",
    };
};

pub const UpdateEventConfigurationByResourceTypesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEventConfigurationByResourceTypesInput, options: CallOptions) !UpdateEventConfigurationByResourceTypesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEventConfigurationByResourceTypesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/event-configurations-resource-types";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.connection_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConnectionStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.device_registration_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeviceRegistrationState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.join) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Join\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.message_delivery_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MessageDeliveryStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.proximity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Proximity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEventConfigurationByResourceTypesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateEventConfigurationByResourceTypesOutput = .{};

    return result;
}
