const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateDataLakeExceptionSubscriptionInput = struct {
    /// The time-to-live (TTL) for the exception message to remain. It is the
    /// duration of time until which the exception message remains.
    exception_time_to_live: ?i64 = null,

    /// The account that is subscribed to receive exception notifications.
    notification_endpoint: []const u8,

    /// The subscription protocol to which exception messages are posted.
    subscription_protocol: []const u8,

    pub const json_field_names = .{
        .exception_time_to_live = "exceptionTimeToLive",
        .notification_endpoint = "notificationEndpoint",
        .subscription_protocol = "subscriptionProtocol",
    };
};

pub const UpdateDataLakeExceptionSubscriptionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataLakeExceptionSubscriptionInput, options: CallOptions) !UpdateDataLakeExceptionSubscriptionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataLakeExceptionSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securitylake", "SecurityLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/datalake/exceptions/subscription";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.exception_time_to_live) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"exceptionTimeToLive\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"notificationEndpoint\":");
    try aws.json.writeValue(@TypeOf(input.notification_endpoint), input.notification_endpoint, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subscriptionProtocol\":");
    try aws.json.writeValue(@TypeOf(input.subscription_protocol), input.subscription_protocol, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataLakeExceptionSubscriptionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateDataLakeExceptionSubscriptionOutput = .{};

    return result;
}
