const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const OwnershipControls = @import("ownership_controls.zig").OwnershipControls;
const serde = @import("serde.zig");

pub const PutBucketOwnershipControlsInput = struct {
    /// The name of the Amazon S3 bucket whose `OwnershipControls` you want to set.
    bucket: []const u8,

    /// Indicates the algorithm used to create the checksum for the object when you
    /// use the SDK. This
    /// header will not provide any additional functionality if you don't use the
    /// SDK. When you send this
    /// header, there must be a corresponding `x-amz-checksum-*algorithm*
    /// ` header
    /// sent. Otherwise, Amazon S3 fails the request with the HTTP status code `400
    /// Bad Request`. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    ///
    /// If you provide an individual checksum, Amazon S3 ignores any provided
    /// `ChecksumAlgorithm`
    /// parameter.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// The MD5 hash of the `OwnershipControls` request body.
    ///
    /// For requests made using the Amazon Web Services Command Line Interface (CLI)
    /// or Amazon Web Services SDKs, this field is calculated automatically.
    content_md5: ?[]const u8 = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// The `OwnershipControls` (BucketOwnerEnforced, BucketOwnerPreferred, or
    /// ObjectWriter) that
    /// you want to apply to this Amazon S3 bucket.
    ownership_controls: OwnershipControls,
};

pub const PutBucketOwnershipControlsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutBucketOwnershipControlsInput, options: CallOptions) !PutBucketOwnershipControlsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutBucketOwnershipControlsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "ownershipControls");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<OwnershipControls xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">");
    try serde.serializeOwnershipControls(allocator, &body_buf, input.ownership_controls);
    try body_buf.appendSlice(allocator, "</OwnershipControls>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutBucketOwnershipControlsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutBucketOwnershipControlsOutput = .{};

    return result;
}
