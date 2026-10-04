const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BucketAccessLogConfig = @import("bucket_access_log_config.zig").BucketAccessLogConfig;
const AccessRules = @import("access_rules.zig").AccessRules;
const BucketCorsConfig = @import("bucket_cors_config.zig").BucketCorsConfig;
const Bucket = @import("bucket.zig").Bucket;
const Operation = @import("operation.zig").Operation;

pub const UpdateBucketInput = struct {
    /// An object that describes the access log configuration for the bucket.
    access_log_config: ?BucketAccessLogConfig = null,

    /// An object that sets the public accessibility of objects in the specified
    /// bucket.
    access_rules: ?AccessRules = null,

    /// The name of the bucket to update.
    bucket_name: []const u8,

    /// Sets the cross-origin resource sharing (CORS) configuration for your bucket.
    /// If a CORS configuration exists, it is replaced with the specified
    /// configuration. For AWS CLI operations, this parameter can also be passed as
    /// a file. For more information, see [Configuring cross-origin resource sharing
    /// (CORS)](https://docs.aws.amazon.com/lightsail/latest/userguide/configure-cors.html).
    ///
    /// CORS information is only returned in a response when you update the CORS
    /// policy.
    cors: ?BucketCorsConfig = null,

    /// An array of strings to specify the Amazon Web Services account IDs that can
    /// access the
    /// bucket.
    ///
    /// You can give a maximum of 10 Amazon Web Services accounts access to a
    /// bucket.
    readonly_access_accounts: ?[]const []const u8 = null,

    /// Specifies whether to enable or suspend versioning of objects in the bucket.
    ///
    /// The following options can be specified:
    ///
    /// * `Enabled` - Enables versioning of objects in the specified bucket.
    ///
    /// * `Suspended` - Suspends versioning of objects in the specified bucket.
    /// Existing object versions are retained.
    versioning: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_log_config = "accessLogConfig",
        .access_rules = "accessRules",
        .bucket_name = "bucketName",
        .cors = "cors",
        .readonly_access_accounts = "readonlyAccessAccounts",
        .versioning = "versioning",
    };
};

pub const UpdateBucketOutput = struct {
    /// An object that describes the bucket that is updated.
    bucket: ?Bucket = null,

    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .operations = "operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBucketInput, options: CallOptions) !UpdateBucketOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBucketInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.UpdateBucket");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBucketOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateBucketOutput, body, allocator);
}
