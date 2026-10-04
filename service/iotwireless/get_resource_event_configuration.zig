const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentifierType = @import("identifier_type.zig").IdentifierType;
const EventNotificationPartnerType = @import("event_notification_partner_type.zig").EventNotificationPartnerType;
const ConnectionStatusEventConfiguration = @import("connection_status_event_configuration.zig").ConnectionStatusEventConfiguration;
const DeviceRegistrationStateEventConfiguration = @import("device_registration_state_event_configuration.zig").DeviceRegistrationStateEventConfiguration;
const JoinEventConfiguration = @import("join_event_configuration.zig").JoinEventConfiguration;
const MessageDeliveryStatusEventConfiguration = @import("message_delivery_status_event_configuration.zig").MessageDeliveryStatusEventConfiguration;
const ProximityEventConfiguration = @import("proximity_event_configuration.zig").ProximityEventConfiguration;

pub const GetResourceEventConfigurationInput = struct {
    /// Resource identifier to opt in for event messaging.
    identifier: []const u8,

    /// Identifier type of the particular resource identifier for event
    /// configuration.
    identifier_type: IdentifierType,

    /// Partner type of the resource if the identifier type is
    /// `PartnerAccountId`.
    partner_type: ?EventNotificationPartnerType = null,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .identifier_type = "IdentifierType",
        .partner_type = "PartnerType",
    };
};

pub const GetResourceEventConfigurationOutput = struct {
    /// Event configuration for the connection status event.
    connection_status: ?ConnectionStatusEventConfiguration = null,

    /// Event configuration for the device registration state event.
    device_registration_state: ?DeviceRegistrationStateEventConfiguration = null,

    /// Event configuration for the join event.
    join: ?JoinEventConfiguration = null,

    /// Event configuration for the message delivery status event.
    message_delivery_status: ?MessageDeliveryStatusEventConfiguration = null,

    /// Event configuration for the proximity event.
    proximity: ?ProximityEventConfiguration = null,

    pub const json_field_names = .{
        .connection_status = "ConnectionStatus",
        .device_registration_state = "DeviceRegistrationState",
        .join = "Join",
        .message_delivery_status = "MessageDeliveryStatus",
        .proximity = "Proximity",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceEventConfigurationInput, options: CallOptions) !GetResourceEventConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceEventConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/event-configurations/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "identifierType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.identifier_type.wireName());
    query_has_prev = true;
    if (input.partner_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "partnerType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceEventConfigurationOutput {
    const result: GetResourceEventConfigurationOutput = try aws.json.parseJsonObject(
        GetResourceEventConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
