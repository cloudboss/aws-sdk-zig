const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InvalidationBatch = @import("invalidation_batch.zig").InvalidationBatch;
const Invalidation = @import("invalidation.zig").Invalidation;
const serde = @import("serde.zig");

pub const CreateInvalidationInput = struct {
    /// The distribution's id.
    distribution_id: []const u8,

    /// The batch information for the invalidation.
    invalidation_batch: InvalidationBatch,
};

pub const CreateInvalidationOutput = struct {
    /// The invalidation's information.
    invalidation: ?Invalidation = null,

    /// The fully qualified URI of the distribution and invalidation batch request,
    /// including the `Invalidation ID`.
    location: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInvalidationInput, options: CallOptions) !CreateInvalidationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInvalidationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/distribution/");
    try path_buf.appendSlice(allocator, input.distribution_id);
    try path_buf.appendSlice(allocator, "/invalidation");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<InvalidationBatch xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try serde.serializeInvalidationBatch(allocator, &body_buf, input.invalidation_batch);
    try body_buf.appendSlice(allocator, "</InvalidationBatch>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInvalidationOutput {
    var result: CreateInvalidationOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
