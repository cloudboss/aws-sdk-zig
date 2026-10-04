const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetDataLakeExceptionSubscriptionInput = struct {
};

pub const GetDataLakeExceptionSubscriptionOutput = struct {
    /// The expiration period and time-to-live (TTL). It is the duration of time
    /// until which the exception message remains.
    exception_time_to_live: ?i64 = null,

    /// The Amazon Web Services account where you receive exception notifications.
    notification_endpoint: ?[]const u8 = null,

    /// The subscription protocol to which exception notifications are posted.
    subscription_protocol: ?[]const u8 = null,

    pub const json_field_names = .{
        .exception_time_to_live = "exceptionTimeToLive",
        .notification_endpoint = "notificationEndpoint",
        .subscription_protocol = "subscriptionProtocol",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataLakeExceptionSubscriptionInput, options: CallOptions) !GetDataLakeExceptionSubscriptionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataLakeExceptionSubscriptionInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("securitylake", "SecurityLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/datalake/exceptions/subscription";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataLakeExceptionSubscriptionOutput {
    const result: GetDataLakeExceptionSubscriptionOutput = try aws.json.parseJsonObject(
        GetDataLakeExceptionSubscriptionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
