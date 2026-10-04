const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AbacStatus = @import("abac_status.zig").AbacStatus;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const serde = @import("serde.zig");

pub const PutBucketAbacInput = struct {
    /// The ABAC status of the general purpose bucket. When ABAC is enabled for the
    /// general purpose bucket, you can use tags to manage access to the general
    /// purpose buckets as well as for cost tracking purposes. When ABAC is disabled
    /// for the general purpose buckets, you can only use tags for cost tracking
    /// purposes. For more information, see [Using tags with S3 general purpose
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/buckets-tagging.html).
    abac_status: AbacStatus,

    /// The name of the general purpose bucket.
    bucket: []const u8,

    /// Indicates the algorithm that you want Amazon S3 to use to create the
    /// checksum. For more
    /// information, see [ Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// The MD5 hash of the `PutBucketAbac` request body.
    ///
    /// For requests made using the Amazon Web Services Command Line Interface (CLI)
    /// or Amazon Web Services SDKs, this field is calculated automatically.
    content_md5: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the general purpose bucket's owner.
    expected_bucket_owner: ?[]const u8 = null,
};

pub const PutBucketAbacOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutBucketAbacInput, options: CallOptions) !PutBucketAbacOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutBucketAbacInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "abac");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<AbacStatus xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">");
    try serde.serializeAbacStatus(allocator, &body_buf, input.abac_status);
    try body_buf.appendSlice(allocator, "</AbacStatus>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    if (input.checksum_algorithm) |v| {
        try request.headers.put(allocator, "x-amz-sdk-checksum-algorithm", v.wireName());
    }
    if (input.content_md5) |v| {
        try request.headers.put(allocator, "Content-MD5", v);
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutBucketAbacOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutBucketAbacOutput = .{};

    return result;
}
