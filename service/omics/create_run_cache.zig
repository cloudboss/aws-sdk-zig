const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CacheBehavior = @import("cache_behavior.zig").CacheBehavior;
const RunCacheStatus = @import("run_cache_status.zig").RunCacheStatus;

pub const CreateRunCacheInput = struct {
    /// Default cache behavior for runs that use this cache. Supported values are:
    ///
    /// `CACHE_ON_FAILURE`: Caches task outputs from completed tasks for runs that
    /// fail. This setting is useful if you're debugging a workflow that fails after
    /// several tasks completed successfully. The subsequent run uses the cache
    /// outputs for previously-completed tasks if the task definition, inputs, and
    /// container in ECR are identical to the prior run.
    ///
    /// `CACHE_ALWAYS`: Caches task outputs from completed tasks for all runs. This
    /// setting is useful in development mode, but do not use it in a production
    /// setting.
    ///
    /// If you don't specify a value, the default behavior is CACHE_ON_FAILURE. When
    /// you start a run that uses this cache, you can override the default cache
    /// behavior.
    ///
    /// For more information, see [Run cache
    /// behavior](https://docs.aws.amazon.com/omics/latest/dev/how-run-cache.html#run-cache-behavior) in the *Amazon Web Services HealthOmics User Guide*.
    cache_behavior: ?CacheBehavior = null,

    /// The Amazon Web Services account ID of the expected owner of the S3 bucket
    /// for the run cache. If not provided, your account ID is set as the owner of
    /// the bucket.
    cache_bucket_owner_id: ?[]const u8 = null,

    /// Specify the S3 location for storing the cached task outputs. This data must
    /// be immediately accessible (not in an archived state).
    cache_s3_location: []const u8,

    /// Enter a description of the run cache.
    description: ?[]const u8 = null,

    /// Enter a user-friendly name for the run cache.
    name: ?[]const u8 = null,

    /// A unique request token, to ensure idempotency. If you don't specify a token,
    /// Amazon Web Services HealthOmics automatically generates a universally unique
    /// identifier (UUID) for the request.
    request_id: []const u8,

    /// Specify one or more tags to associate with this run cache.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cache_behavior = "cacheBehavior",
        .cache_bucket_owner_id = "cacheBucketOwnerId",
        .cache_s3_location = "cacheS3Location",
        .description = "description",
        .name = "name",
        .request_id = "requestId",
        .tags = "tags",
    };
};

pub const CreateRunCacheOutput = struct {
    /// Unique resource identifier for the run cache.
    arn: ?[]const u8 = null,

    /// Identifier for the run cache.
    id: ?[]const u8 = null,

    /// Run cache status.
    status: ?RunCacheStatus = null,

    /// The tags associated with this run cache.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRunCacheInput, options: CallOptions) !CreateRunCacheOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRunCacheInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/runCache";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cache_behavior) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cacheBehavior\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.cache_bucket_owner_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cacheBucketOwnerId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"cacheS3Location\":");
    try aws.json.writeValue(@TypeOf(input.cache_s3_location), input.cache_s3_location, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"requestId\":");
    try aws.json.writeValue(@TypeOf(input.request_id), input.request_id, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRunCacheOutput {
    const result: CreateRunCacheOutput = try aws.json.parseJsonObject(
        CreateRunCacheOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
