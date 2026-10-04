const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VersioningConfiguration = @import("versioning_configuration.zig").VersioningConfiguration;
const serde = @import("serde.zig");

pub const PutBucketVersioningInput = struct {
    /// The Amazon Web Services account ID of the S3 on Outposts bucket.
    account_id: []const u8,

    /// The S3 on Outposts bucket to set the versioning state for.
    bucket: []const u8,

    /// The concatenation of the authentication device's serial number, a space, and
    /// the value
    /// that is displayed on your authentication device.
    mfa: ?[]const u8 = null,

    /// The root-level tag for the `VersioningConfiguration` parameters.
    versioning_configuration: VersioningConfiguration,
};

pub const PutBucketVersioningOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutBucketVersioningInput, options: CallOptions) !PutBucketVersioningOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutBucketVersioningInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20180820/bucket/");
    try path_buf.appendSlice(allocator, input.bucket);
    try path_buf.appendSlice(allocator, "/versioning");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<VersioningConfiguration xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
    try serde.serializeVersioningConfiguration(allocator, &body_buf, input.versioning_configuration);
    try body_buf.appendSlice(allocator, "</VersioningConfiguration>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);
    if (input.mfa) |v| {
        try request.headers.put(allocator, "x-amz-mfa", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutBucketVersioningOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutBucketVersioningOutput = .{};

    return result;
}
