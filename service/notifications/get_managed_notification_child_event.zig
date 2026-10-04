const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LocaleCode = @import("locale_code.zig").LocaleCode;
const ManagedNotificationChildEvent = @import("managed_notification_child_event.zig").ManagedNotificationChildEvent;

pub const GetManagedNotificationChildEventInput = struct {
    /// The Amazon Resource Name (ARN) of the `ManagedNotificationChildEvent` to
    /// return.
    arn: []const u8,

    /// The locale code of the language used for the retrieved
    /// `ManagedNotificationChildEvent`. The default locale is English `en_US`.
    locale: ?LocaleCode = null,

    pub const json_field_names = .{
        .arn = "arn",
        .locale = "locale",
    };
};

pub const GetManagedNotificationChildEventOutput = struct {
    /// The ARN of the resource.
    arn: []const u8,

    /// The content of the `ManagedNotificationChildEvent`.
    content: ?ManagedNotificationChildEvent = null,

    /// The creation time of the `ManagedNotificationChildEvent`.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the `ManagedNotificationConfiguration`
    /// associated with the `ManagedNotificationChildEvent`.
    managed_notification_configuration_arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .content = "content",
        .creation_time = "creationTime",
        .managed_notification_configuration_arn = "managedNotificationConfigurationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetManagedNotificationChildEventInput, options: CallOptions) !GetManagedNotificationChildEventOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetManagedNotificationChildEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/managed-notification-child-events/");
    try path_buf.appendSlice(allocator, input.arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.locale) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "locale=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetManagedNotificationChildEventOutput {
    var result: GetManagedNotificationChildEventOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetManagedNotificationChildEventOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
