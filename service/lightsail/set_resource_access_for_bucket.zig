const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceBucketAccess = @import("resource_bucket_access.zig").ResourceBucketAccess;
const Operation = @import("operation.zig").Operation;

pub const SetResourceAccessForBucketInput = struct {
    /// The access setting.
    ///
    /// The following access settings are available:
    ///
    /// * `allow` - Allows access to the bucket and its objects.
    ///
    /// * `deny` - Denies access to the bucket and its objects. Use this setting to
    /// remove access for a resource previously set to `allow`.
    access: ResourceBucketAccess,

    /// The name of the bucket for which to set access to another Lightsail
    /// resource.
    bucket_name: []const u8,

    /// The name of the Lightsail instance for which to set bucket access. The
    /// instance must be
    /// in a running or stopped state.
    resource_name: []const u8,

    pub const json_field_names = .{
        .access = "access",
        .bucket_name = "bucketName",
        .resource_name = "resourceName",
    };
};

pub const SetResourceAccessForBucketOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetResourceAccessForBucketInput, options: CallOptions) !SetResourceAccessForBucketOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetResourceAccessForBucketInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.SetResourceAccessForBucket");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetResourceAccessForBucketOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SetResourceAccessForBucketOutput, body, allocator);
}
