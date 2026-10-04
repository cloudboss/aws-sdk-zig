const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const Tagging = @import("tagging.zig").Tagging;
const serde = @import("serde.zig");

pub const PutBucketTaggingInput = struct {
    /// The bucket name.
    bucket: []const u8,

    /// Indicates the algorithm used to create the checksum for the request when you
    /// use the SDK. This header will not provide any
    /// additional functionality if you don't use the SDK. When you send this
    /// header, there must be a corresponding `x-amz-checksum` or
    /// `x-amz-trailer` header sent. Otherwise, Amazon S3 fails the request with the
    /// HTTP status code `400 Bad Request`. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    ///
    /// If you provide an individual checksum, Amazon S3 ignores any provided
    /// `ChecksumAlgorithm`
    /// parameter.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// The Base64 encoded 128-bit `MD5` digest of the data. You must use this
    /// header as a
    /// message integrity check to verify that the request body was not corrupted in
    /// transit. For more
    /// information, see [RFC 1864](http://www.ietf.org/rfc/rfc1864.txt).
    ///
    /// For requests made using the Amazon Web Services Command Line Interface (CLI)
    /// or Amazon Web Services SDKs, this field is calculated automatically.
    content_md5: ?[]const u8 = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// Container for the `TagSet` and `Tag` elements.
    tagging: Tagging,
};

pub const PutBucketTaggingOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutBucketTaggingInput, options: CallOptions) !PutBucketTaggingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutBucketTaggingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "tagging");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<Tagging xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">");
    try serde.serializeTagging(allocator, &body_buf, input.tagging);
    try body_buf.appendSlice(allocator, "</Tagging>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    const body_for_md5: []const u8 = if (@TypeOf(body) == ?[]const u8) (body orelse "") else body;
    if (body_for_md5.len > 0) {
        var md5_digest: [16]u8 = undefined;
        std.crypto.hash.Md5.hash(body_for_md5, &md5_digest, .{});
        const md5_len = std.base64.standard.Encoder.calcSize(md5_digest.len);
        const md5_b64 = try allocator.alloc(u8, md5_len);
        _ = std.base64.standard.Encoder.encode(md5_b64, &md5_digest);
        try request.headers.put(allocator, "Content-MD5", md5_b64);
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutBucketTaggingOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutBucketTaggingOutput = .{};

    return result;
}
