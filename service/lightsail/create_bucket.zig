const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Bucket = @import("bucket.zig").Bucket;
const Operation = @import("operation.zig").Operation;

pub const CreateBucketInput = struct {
    /// The name for the bucket.
    ///
    /// For more information about bucket names, see [Bucket naming rules in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/bucket-naming-rules-in-amazon-lightsail) in the *Amazon Lightsail Developer
    /// Guide*.
    bucket_name: []const u8,

    /// The ID of the bundle to use for the bucket.
    ///
    /// A bucket bundle specifies the monthly cost, storage space, and data transfer
    /// quota for a
    /// bucket.
    ///
    /// Use the
    /// [GetBucketBundles](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_GetBucketBundles.html) action to get a list of
    /// bundle IDs that you can specify.
    ///
    /// Use the
    /// [UpdateBucketBundle](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_UpdateBucketBundle.html) action to change the
    /// bundle after the bucket is created.
    bundle_id: []const u8,

    /// A Boolean value that indicates whether to enable versioning of objects in
    /// the
    /// bucket.
    ///
    /// For more information about versioning, see [Enabling and suspending object
    /// versioning in a bucket in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-managing-bucket-object-versioning) in the
    /// *Amazon Lightsail Developer Guide*.
    enable_object_versioning: ?bool = null,

    /// The tag keys and optional values to add to the bucket during creation.
    ///
    /// Use the
    /// [TagResource](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_TagResource.html) action to tag the bucket after it's
    /// created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .bundle_id = "bundleId",
        .enable_object_versioning = "enableObjectVersioning",
        .tags = "tags",
    };
};

pub const CreateBucketOutput = struct {
    /// An object that describes the bucket that is created.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBucketInput, options: CallOptions) !CreateBucketOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBucketInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.CreateBucket");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBucketOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateBucketOutput, body, allocator);
}
