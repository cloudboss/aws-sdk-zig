const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateManagedNotificationChannelAssociationInput = struct {
    /// The identifier of the channel association to update. You can specify one of
    /// the following:
    ///
    /// * An Account contact identifier.
    /// * A Channel ARN.
    channel_identifier: []const u8,

    /// Specifies whether the association is subscribed to sensitive events. The
    /// `notifications:SubscribeSensitiveEvents` permission controls access to
    /// sensitive events.
    is_sensitive_events_subscribed: ?bool = null,

    /// The Amazon Resource Name (ARN) of the `ManagedNotificationConfiguration`
    /// whose Channel association property you want to update.
    managed_notification_configuration_arn: []const u8,

    pub const json_field_names = .{
        .channel_identifier = "channelIdentifier",
        .is_sensitive_events_subscribed = "isSensitiveEventsSubscribed",
        .managed_notification_configuration_arn = "managedNotificationConfigurationArn",
    };
};

pub const UpdateManagedNotificationChannelAssociationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateManagedNotificationChannelAssociationInput, options: CallOptions) !UpdateManagedNotificationChannelAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "notifications", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateManagedNotificationChannelAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/channels/update-managed-notification-channel-association";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"channelIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.channel_identifier), input.channel_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.is_sensitive_events_subscribed) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"isSensitiveEventsSubscribed\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"managedNotificationConfigurationArn\":");
    try aws.json.writeValue(@TypeOf(input.managed_notification_configuration_arn), input.managed_notification_configuration_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateManagedNotificationChannelAssociationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateManagedNotificationChannelAssociationOutput = .{};

    return result;
}
