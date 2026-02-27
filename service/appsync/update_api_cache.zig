const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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
    ttl: i64 = 0,

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
    type: ApiCacheType,

    pub const json_field_names = .{
        .api_caching_behavior = "apiCachingBehavior",
        .api_id = "apiId",
        .health_metrics_config = "healthMetricsConfig",
        .ttl = "ttl",
        .type = "type",
    };
};

pub const UpdateApiCacheOutput = struct {
    /// The `ApiCache` object.
    api_cache: ?ApiCache = null,

    pub const json_field_names = .{
        .api_cache = "apiCache",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApiCacheInput, options: Options) !UpdateApiCacheOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appsync");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateApiCacheInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v1/apis/");
    try path_buf.appendSlice(alloc, input.api_id);
    try path_buf.appendSlice(alloc, "/ApiCaches/update");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"apiCachingBehavior\":");
    try aws.json.writeValue(@TypeOf(input.api_caching_behavior), input.api_caching_behavior, alloc, &body_buf);
    has_prev = true;
    if (input.health_metrics_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"healthMetricsConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ttl\":");
    try aws.json.writeValue(@TypeOf(input.ttl), input.ttl, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.type), input.type, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateApiCacheOutput {
    var result: UpdateApiCacheOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateApiCacheOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApiKeyLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .api_key_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApiKeyValidityOutOfBoundsException")) {
        return .{ .arena = arena, .kind = .{ .api_key_validity_out_of_bounds_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApiLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .api_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GraphQLSchemaException")) {
        return .{ .arena = arena, .kind = .{ .graph_ql_schema_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
