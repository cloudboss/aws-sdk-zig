const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationChannelConfig = @import("notification_channel_config.zig").NotificationChannelConfig;

pub const AddNotificationChannelInput = struct {
    /// A `NotificationChannelConfig` object that specifies what type of
    /// notification channel to add. The one
    /// supported notification channel is Amazon Simple Notification Service (Amazon
    /// SNS).
    config: NotificationChannelConfig,

    pub const json_field_names = .{
        .config = "Config",
    };
};

pub const AddNotificationChannelOutput = struct {
    /// The ID of the added notification channel.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddNotificationChannelInput, options: CallOptions) !AddNotificationChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devops-guru", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddNotificationChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devops-guru", "DevOps Guru", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/channels";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Config\":");
    try aws.json.writeValue(@TypeOf(input.config), input.config, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddNotificationChannelOutput {
    var result: AddNotificationChannelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AddNotificationChannelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
