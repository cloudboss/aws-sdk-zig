const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeBandwidthRateLimitInput = struct {
    gateway_arn: []const u8,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
    };
};

pub const DescribeBandwidthRateLimitOutput = struct {
    /// The average download bandwidth rate limit in bits per second. This field
    /// does not appear
    /// in the response if the download rate limit is not set.
    average_download_rate_limit_in_bits_per_sec: ?i64 = null,

    /// The average upload bandwidth rate limit in bits per second. This field does
    /// not appear
    /// in the response if the upload rate limit is not set.
    average_upload_rate_limit_in_bits_per_sec: ?i64 = null,

    gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .average_download_rate_limit_in_bits_per_sec = "AverageDownloadRateLimitInBitsPerSec",
        .average_upload_rate_limit_in_bits_per_sec = "AverageUploadRateLimitInBitsPerSec",
        .gateway_arn = "GatewayARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBandwidthRateLimitInput, options: CallOptions) !DescribeBandwidthRateLimitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBandwidthRateLimitInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.DescribeBandwidthRateLimit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBandwidthRateLimitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeBandwidthRateLimitOutput, body, allocator);
}
