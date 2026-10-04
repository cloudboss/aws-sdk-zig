const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamingDistributionConfig = @import("streaming_distribution_config.zig").StreamingDistributionConfig;
const StreamingDistribution = @import("streaming_distribution.zig").StreamingDistribution;
const serde = @import("serde.zig");

pub const CreateStreamingDistributionInput = struct {
    /// The streaming distribution's configuration information.
    streaming_distribution_config: StreamingDistributionConfig,
};

pub const CreateStreamingDistributionOutput = struct {
    /// The current version of the streaming distribution created.
    e_tag: ?[]const u8 = null,

    /// The fully qualified URI of the new streaming distribution resource just
    /// created.
    location: ?[]const u8 = null,

    /// The streaming distribution's information.
    streaming_distribution: ?StreamingDistribution = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStreamingDistributionInput, options: CallOptions) !CreateStreamingDistributionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudfront", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStreamingDistributionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/streaming-distribution";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<StreamingDistributionConfig xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try serde.serializeStreamingDistributionConfig(allocator, &body_buf, input.streaming_distribution_config);
    try body_buf.appendSlice(allocator, "</StreamingDistributionConfig>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStreamingDistributionOutput {
    var result: CreateStreamingDistributionOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
