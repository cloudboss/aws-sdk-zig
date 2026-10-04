const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateSubscriptionsToEventBridgeInput = struct {
    /// When set to true, this operation migrates DMS subscriptions for Amazon
    /// SNS notifications no matter what your replication instance version is. If
    /// not set or set to
    /// false, this operation runs only when all your replication instances are from
    /// DMS version 3.4.5 or higher.
    force_move: ?bool = null,

    pub const json_field_names = .{
        .force_move = "ForceMove",
    };
};

pub const UpdateSubscriptionsToEventBridgeOutput = struct {
    /// A string that indicates how many event subscriptions were migrated and how
    /// many remain
    /// to be migrated.
    result: ?[]const u8 = null,

    pub const json_field_names = .{
        .result = "Result",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSubscriptionsToEventBridgeInput, options: CallOptions) !UpdateSubscriptionsToEventBridgeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSubscriptionsToEventBridgeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.UpdateSubscriptionsToEventBridge");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSubscriptionsToEventBridgeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateSubscriptionsToEventBridgeOutput, body, allocator);
}
