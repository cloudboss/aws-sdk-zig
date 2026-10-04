const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingMode = @import("billing_mode.zig").BillingMode;
const Connection = @import("connection.zig").Connection;
const HasLogicalRedundancy = @import("has_logical_redundancy.zig").HasLogicalRedundancy;
const LagState = @import("lag_state.zig").LagState;
const MacSecKey = @import("mac_sec_key.zig").MacSecKey;
const RateLimiterStatus = @import("rate_limiter_status.zig").RateLimiterStatus;
const Tag = @import("tag.zig").Tag;

pub const DeleteLagInput = struct {
    /// The ID of the LAG.
    lag_id: []const u8,

    pub const json_field_names = .{
        .lag_id = "lagId",
    };
};

pub const DeleteLagOutput = @import("lag.zig").Lag;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteLagInput, options: CallOptions) !DeleteLagOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "directconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteLagInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("directconnect", "Direct Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "OvertureService.DeleteLag");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteLagOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteLagOutput, body, allocator);
}
