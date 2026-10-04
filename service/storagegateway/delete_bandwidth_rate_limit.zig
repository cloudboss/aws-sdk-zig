const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteBandwidthRateLimitInput = struct {
    /// One of the BandwidthType values that indicates the gateway bandwidth rate
    /// limit to
    /// delete.
    ///
    /// Valid Values: `UPLOAD` | `DOWNLOAD` | `ALL`
    bandwidth_type: []const u8,

    gateway_arn: []const u8,

    pub const json_field_names = .{
        .bandwidth_type = "BandwidthType",
        .gateway_arn = "GatewayARN",
    };
};

pub const DeleteBandwidthRateLimitOutput = struct {
    gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBandwidthRateLimitInput, options: CallOptions) !DeleteBandwidthRateLimitOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "storagegateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBandwidthRateLimitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.DeleteBandwidthRateLimit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBandwidthRateLimitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteBandwidthRateLimitOutput, body, allocator);
}
