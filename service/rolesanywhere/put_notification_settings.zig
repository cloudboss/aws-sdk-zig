const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationSetting = @import("notification_setting.zig").NotificationSetting;
const TrustAnchorDetail = @import("trust_anchor_detail.zig").TrustAnchorDetail;

pub const PutNotificationSettingsInput = struct {
    /// A list of notification settings to be associated to the trust anchor.
    notification_settings: []const NotificationSetting,

    /// The unique identifier of the trust anchor.
    trust_anchor_id: []const u8,

    pub const json_field_names = .{
        .notification_settings = "notificationSettings",
        .trust_anchor_id = "trustAnchorId",
    };
};

pub const PutNotificationSettingsOutput = struct {
    trust_anchor: ?TrustAnchorDetail = null,

    pub const json_field_names = .{
        .trust_anchor = "trustAnchor",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutNotificationSettingsInput, options: CallOptions) !PutNotificationSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutNotificationSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rolesanywhere", "RolesAnywhere", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/put-notifications-settings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"notificationSettings\":");
    try aws.json.writeValue(@TypeOf(input.notification_settings), input.notification_settings, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutNotificationSettingsOutput {
    var result: PutNotificationSettingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutNotificationSettingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
