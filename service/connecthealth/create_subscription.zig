const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionStatus = @import("subscription_status.zig").SubscriptionStatus;

pub const CreateSubscriptionInput = struct {
    /// The unique identifier of the parent Domain.
    domain_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "domainId",
    };
};

pub const CreateSubscriptionOutput = struct {
    activated_at: ?i64 = null,

    arn: []const u8,

    created_at: i64,

    deactivated_at: ?i64 = null,

    domain_id: []const u8,

    last_updated_at: i64,

    status: SubscriptionStatus,

    subscription_id: []const u8,

    pub const json_field_names = .{
        .activated_at = "activatedAt",
        .arn = "arn",
        .created_at = "createdAt",
        .deactivated_at = "deactivatedAt",
        .domain_id = "domainId",
        .last_updated_at = "lastUpdatedAt",
        .status = "status",
        .subscription_id = "subscriptionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSubscriptionInput, options: CallOptions) !CreateSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "health-agent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health-agent", "ConnectHealth", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_id);
    try path_buf.appendSlice(allocator, "/subscriptions");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSubscriptionOutput {
    const result: CreateSubscriptionOutput = try aws.json.parseJsonObject(
        CreateSubscriptionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
