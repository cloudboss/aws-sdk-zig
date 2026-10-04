const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationSubscriptionStatus = @import("notification_subscription_status.zig").NotificationSubscriptionStatus;
const AccountSettings = @import("account_settings.zig").AccountSettings;

pub const PutAccountSettingsInput = struct {
    /// Desired notification subscription status.
    notification_subscription_status: ?NotificationSubscriptionStatus = null,

    pub const json_field_names = .{
        .notification_subscription_status = "notificationSubscriptionStatus",
    };
};

pub const PutAccountSettingsOutput = struct {
    account_settings: ?AccountSettings = null,

    pub const json_field_names = .{
        .account_settings = "accountSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAccountSettingsInput, options: CallOptions) !PutAccountSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "artifact", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAccountSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("artifact", "Artifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/account-settings/put";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.notification_subscription_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"notificationSubscriptionStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAccountSettingsOutput {
    var result: PutAccountSettingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutAccountSettingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
