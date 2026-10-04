const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationSettingKey = @import("notification_setting_key.zig").NotificationSettingKey;
const TrustAnchorDetail = @import("trust_anchor_detail.zig").TrustAnchorDetail;

pub const ResetNotificationSettingsInput = struct {
    /// A list of notification setting keys to reset. A notification setting key
    /// includes the event and the channel.
    notification_setting_keys: []const NotificationSettingKey,

    /// The unique identifier of the trust anchor.
    trust_anchor_id: []const u8,

    pub const json_field_names = .{
        .notification_setting_keys = "notificationSettingKeys",
        .trust_anchor_id = "trustAnchorId",
    };
};

pub const ResetNotificationSettingsOutput = struct {
    trust_anchor: ?TrustAnchorDetail = null,

    pub const json_field_names = .{
        .trust_anchor = "trustAnchor",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResetNotificationSettingsInput, options: CallOptions) !ResetNotificationSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rolesanywhere", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ResetNotificationSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rolesanywhere", "RolesAnywhere", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/reset-notifications-settings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"notificationSettingKeys\":");
    try aws.json.writeValue(@TypeOf(input.notification_setting_keys), input.notification_setting_keys, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"trustAnchorId\":");
    try aws.json.writeValue(@TypeOf(input.trust_anchor_id), input.trust_anchor_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResetNotificationSettingsOutput {
    const result: ResetNotificationSettingsOutput = try aws.json.parseJsonObject(
        ResetNotificationSettingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
