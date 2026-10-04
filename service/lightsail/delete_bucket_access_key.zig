const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Operation = @import("operation.zig").Operation;

pub const DeleteBucketAccessKeyInput = struct {
    /// The ID of the access key to delete.
    ///
    /// Use the
    /// [GetBucketAccessKeys](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_GetBucketAccessKeys.html) action to get a
    /// list of access key IDs that you can specify.
    access_key_id: []const u8,

    /// The name of the bucket that the access key belongs to.
    bucket_name: []const u8,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .bucket_name = "bucketName",
    };
};

pub const DeleteBucketAccessKeyOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBucketAccessKeyInput, options: CallOptions) !DeleteBucketAccessKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBucketAccessKeyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.DeleteBucketAccessKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBucketAccessKeyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteBucketAccessKeyOutput, body, allocator);
}
