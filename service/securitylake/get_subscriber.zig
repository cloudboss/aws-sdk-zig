const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriberResource = @import("subscriber_resource.zig").SubscriberResource;

pub const GetSubscriberInput = struct {
    /// A value created by Amazon Security Lake that uniquely identifies your
    /// `GetSubscriber` API request.
    subscriber_id: []const u8,

    pub const json_field_names = .{
        .subscriber_id = "subscriberId",
    };
};

pub const GetSubscriberOutput = struct {
    /// The subscriber information for the specified subscriber ID.
    subscriber: ?SubscriberResource = null,

    pub const json_field_names = .{
        .subscriber = "subscriber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSubscriberInput, options: CallOptions) !GetSubscriberOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSubscriberInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securitylake", "SecurityLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/subscribers/");
    try path_buf.appendSlice(allocator, input.subscriber_id);
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSubscriberOutput {
    var result: GetSubscriberOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSubscriberOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
