const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationConfiguration = @import("notification_configuration.zig").NotificationConfiguration;

pub const CreateSubscriberNotificationInput = struct {
    /// Specify the configuration using which you want to create the subscriber
    /// notification.
    configuration: NotificationConfiguration,

    /// The subscriber ID for the notification subscription.
    subscriber_id: []const u8,

    pub const json_field_names = .{
        .configuration = "configuration",
        .subscriber_id = "subscriberId",
    };
};

pub const CreateSubscriberNotificationOutput = struct {
    /// The subscriber endpoint to which exception messages are posted.
    subscriber_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .subscriber_endpoint = "subscriberEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSubscriberNotificationInput, options: CallOptions) !CreateSubscriberNotificationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securitylake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSubscriberNotificationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securitylake", "SecurityLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/subscribers/");
    try path_buf.appendSlice(allocator, input.subscriber_id);
    try path_buf.appendSlice(allocator, "/notification");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSubscriberNotificationOutput {
    var result: CreateSubscriberNotificationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSubscriberNotificationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
