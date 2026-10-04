const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutBucketPolicyInput = struct {
    /// The Amazon Web Services account ID of the Outposts bucket.
    account_id: []const u8,

    /// Specifies the bucket.
    ///
    /// For using this parameter with Amazon S3 on Outposts with the REST API, you
    /// must specify the name and the x-amz-outpost-id as well.
    ///
    /// For using this parameter with S3 on Outposts with the Amazon Web Services
    /// SDK and CLI, you must specify the ARN of the bucket accessed in the format
    /// `arn:aws:s3-outposts:::outpost//bucket/`. For example, to access the bucket
    /// `reports` through Outpost `my-outpost` owned by account `123456789012` in
    /// Region `us-west-2`, use the URL encoding of
    /// `arn:aws:s3-outposts:us-west-2:123456789012:outpost/my-outpost/bucket/reports`. The value must be URL encoded.
    bucket: []const u8,

    /// Set this parameter to true to confirm that you want to remove your
    /// permissions to change
    /// this bucket policy in the future.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    confirm_remove_self_bucket_access: ?bool = null,

    /// The bucket policy as a JSON document.
    policy: []const u8,
};

pub const PutBucketPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutBucketPolicyInput, options: CallOptions) !PutBucketPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutBucketPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20180820/bucket/");
    try path_buf.appendSlice(allocator, input.bucket);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<PutBucketPolicyRequest xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
    try body_buf.appendSlice(allocator, "<Policy>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.policy);
    try body_buf.appendSlice(allocator, "</Policy>");
    try body_buf.appendSlice(allocator, "</PutBucketPolicyRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);
    if (input.confirm_remove_self_bucket_access) |v| {
        try request.headers.put(allocator, "x-amz-confirm-remove-self-bucket-access", if (v) "true" else "false");
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutBucketPolicyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutBucketPolicyOutput = .{};

    return result;
}
