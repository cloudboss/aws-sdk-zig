const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CacheBehavior = @import("cache_behavior.zig").CacheBehavior;
const RunCacheStatus = @import("run_cache_status.zig").RunCacheStatus;

pub const GetRunCacheInput = struct {
    /// The identifier of the run cache to retrieve.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetRunCacheOutput = struct {
    /// Unique resource identifier for the run cache.
    arn: ?[]const u8 = null,

    /// The default cache behavior for runs using this cache.
    cache_behavior: ?CacheBehavior = null,

    /// The identifier of the bucket owner.
    cache_bucket_owner_id: ?[]const u8 = null,

    /// The S3 URI where the cache data is stored.
    cache_s3_uri: ?[]const u8 = null,

    /// Creation time of the run cache (an ISO 8601 formatted string).
    creation_time: ?i64 = null,

    /// The run cache description.
    description: ?[]const u8 = null,

    /// The run cache ID.
    id: ?[]const u8 = null,

    /// The run cache name.
    name: ?[]const u8 = null,

    /// The run cache status.
    status: ?RunCacheStatus = null,

    /// The tags associated with the run cache.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cache_behavior = "cacheBehavior",
        .cache_bucket_owner_id = "cacheBucketOwnerId",
        .cache_s3_uri = "cacheS3Uri",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRunCacheInput, options: CallOptions) !GetRunCacheOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRunCacheInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/runCache/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRunCacheOutput {
    const result: GetRunCacheOutput = try aws.json.parseJsonObject(
        GetRunCacheOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
