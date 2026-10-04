const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApiCachingBehavior = @import("api_caching_behavior.zig").ApiCachingBehavior;
const CacheHealthMetricsConfig = @import("cache_health_metrics_config.zig").CacheHealthMetricsConfig;
const ApiCacheType = @import("api_cache_type.zig").ApiCacheType;
const ApiCache = @import("api_cache.zig").ApiCache;

pub const UpdateApiCacheInput = struct {
    /// Caching behavior.
    ///
    /// * **FULL_REQUEST_CACHING**: All requests from the
    /// same user are cached. Individual resolvers are automatically cached. All API
    /// calls
    /// will try to return responses from the cache.
    ///
    /// * **PER_RESOLVER_CACHING**: Individual resolvers
    /// that you specify are cached.
    ///
    /// * **OPERATION_LEVEL_CACHING**: Full requests are cached together and
    ///   returned without executing resolvers.
    api_caching_behavior: ApiCachingBehavior,

    /// The GraphQL API ID.
    api_id: []const u8,

    /// Controls how cache health metrics will be emitted to CloudWatch. Cache
    /// health metrics
    /// include:
    ///
    /// * NetworkBandwidthOutAllowanceExceeded: The network packets dropped because
    ///   the
    /// throughput exceeded the aggregated bandwidth limit. This is useful for
    /// diagnosing
    /// bottlenecks in a cache configuration.
    ///
    /// * EngineCPUUtilization: The CPU utilization (percentage) allocated to the
    ///   Redis
    /// process. This is useful for diagnosing bottlenecks in a cache
    /// configuration.
    ///
    /// Metrics will be recorded by API ID. You can set the value to `ENABLED` or
    /// `DISABLED`.
    health_metrics_config: ?CacheHealthMetricsConfig = null,

    /// TTL in seconds for cache entries.
    ///
    /// Valid values are 1–3,600 seconds.
    ttl: ?i64 = null,

    /// The cache instance type. Valid values are
    ///
    /// * `SMALL`
    ///
    /// * `MEDIUM`
    ///
    /// * `LARGE`
    ///
    /// * `XLARGE`
    ///
    /// * `LARGE_2X`
    ///
    /// * `LARGE_4X`
    ///
    /// * `LARGE_8X` (not available in all regions)
    ///
    /// * `LARGE_12X`
    ///
    /// Historically, instance types were identified by an EC2-style value. As of
    /// July 2020, this is deprecated, and the generic identifiers above should be
    /// used.
    ///
    /// The following legacy instance types are available, but their use is
    /// discouraged:
    ///
    /// * **T2_SMALL**: A t2.small instance type.
    ///
    /// * **T2_MEDIUM**: A t2.medium instance type.
    ///
    /// * **R4_LARGE**: A r4.large instance type.
    ///
    /// * **R4_XLARGE**: A r4.xlarge instance type.
    ///
    /// * **R4_2XLARGE**: A r4.2xlarge instance type.
    ///
    /// * **R4_4XLARGE**: A r4.4xlarge instance type.
    ///
    /// * **R4_8XLARGE**: A r4.8xlarge instance type.
    @"type": ApiCacheType,

    pub const json_field_names = .{
        .api_caching_behavior = "apiCachingBehavior",
        .api_id = "apiId",
        .health_metrics_config = "healthMetricsConfig",
        .ttl = "ttl",
        .@"type" = "type",
    };
};

pub const UpdateApiCacheOutput = struct {
    /// The `ApiCache` object.
    api_cache: ?ApiCache = null,

    pub const json_field_names = .{
        .api_cache = "apiCache",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApiCacheInput, options: CallOptions) !UpdateApiCacheOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appsync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApiCacheInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/ApiCaches/update");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"apiCachingBehavior\":");
    try aws.json.writeValue(@TypeOf(input.api_caching_behavior), input.api_caching_behavior, allocator, &body_buf);
    has_prev = true;
    if (input.health_metrics_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"healthMetricsConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ttl\":");
    try aws.json.writeValue(@TypeOf(input.ttl), input.ttl, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApiCacheOutput {
    const result: UpdateApiCacheOutput = try aws.json.parseJsonObject(
        UpdateApiCacheOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
