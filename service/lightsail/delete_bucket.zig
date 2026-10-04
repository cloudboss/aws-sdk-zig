const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Operation = @import("operation.zig").Operation;

pub const DeleteBucketInput = struct {
    /// The name of the bucket to delete.
    ///
    /// Use the
    /// [GetBuckets](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_GetBuckets.html) action to get a list of bucket names
    /// that you can specify.
    bucket_name: []const u8,

    /// A Boolean value that indicates whether to force delete the bucket.
    ///
    /// You must force delete the bucket if it has one of the following conditions:
    ///
    /// * The bucket is the origin of a distribution.
    ///
    /// * The bucket has instances that were granted access to it using the
    ///   [SetResourceAccessForBucket](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_SetResourceAccessForBucket.html) action.
    ///
    /// * The bucket has objects.
    ///
    /// * The bucket has access keys.
    ///
    /// Force deleting a bucket might impact other resources that rely on the
    /// bucket, such as
    /// instances, distributions, or software that use the issued access keys.
    force_delete: ?bool = null,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .force_delete = "forceDelete",
    };
};

pub const DeleteBucketOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBucketInput, options: CallOptions) !DeleteBucketOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBucketInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.DeleteBucket");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBucketOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteBucketOutput, body, allocator);
}
