const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CachingConfig = @import("caching_config.zig").CachingConfig;
const ResolverKind = @import("resolver_kind.zig").ResolverKind;
const ResolverLevelMetricsConfig = @import("resolver_level_metrics_config.zig").ResolverLevelMetricsConfig;
const PipelineConfig = @import("pipeline_config.zig").PipelineConfig;
const AppSyncRuntime = @import("app_sync_runtime.zig").AppSyncRuntime;
const SyncConfig = @import("sync_config.zig").SyncConfig;
const Resolver = @import("resolver.zig").Resolver;

pub const CreateResolverInput = struct {
    /// The ID for the GraphQL API for which the resolver is being created.
    api_id: []const u8,

    /// The caching configuration for the resolver.
    caching_config: ?CachingConfig = null,

    /// The `resolver` code that contains the request and response functions. When
    /// code is used, the `runtime` is required. The `runtime` value must be
    /// `APPSYNC_JS`.
    code: ?[]const u8 = null,

    /// The name of the data source for which the resolver is being created.
    data_source_name: ?[]const u8 = null,

    /// The name of the field to attach the resolver to.
    field_name: []const u8,

    /// The resolver type.
    ///
    /// * **UNIT**: A UNIT resolver type. A UNIT resolver is
    /// the default resolver type. You can use a UNIT resolver to run a GraphQL
    /// query against
    /// a single data source.
    ///
    /// * **PIPELINE**: A PIPELINE resolver type. You can
    /// use a PIPELINE resolver to invoke a series of `Function` objects in a
    /// serial manner. You can use a pipeline resolver to run a GraphQL query
    /// against
    /// multiple data sources.
    kind: ?ResolverKind = null,

    /// The maximum batching size for a resolver.
    max_batch_size: i32 = 0,

    /// Enables or disables enhanced resolver metrics for specified resolvers. Note
    /// that
    /// `metricsConfig` won't be used unless the
    /// `resolverLevelMetricsBehavior` value is set to
    /// `PER_RESOLVER_METRICS`. If the `resolverLevelMetricsBehavior` is
    /// set to `FULL_REQUEST_RESOLVER_METRICS` instead, `metricsConfig` will
    /// be ignored. However, you can still set its value.
    ///
    /// `metricsConfig` can be `ENABLED` or `DISABLED`.
    metrics_config: ?ResolverLevelMetricsConfig = null,

    /// The `PipelineConfig`.
    pipeline_config: ?PipelineConfig = null,

    /// The mapping template to use for requests.
    ///
    /// A resolver uses a request mapping template to convert a GraphQL expression
    /// into a format
    /// that a data source can understand. Mapping templates are written in Apache
    /// Velocity
    /// Template Language (VTL).
    ///
    /// VTL request mapping templates are optional when using an Lambda data
    /// source. For all other data sources, VTL request and response mapping
    /// templates are
    /// required.
    request_mapping_template: ?[]const u8 = null,

    /// The mapping template to use for responses from the data source.
    response_mapping_template: ?[]const u8 = null,

    runtime: ?AppSyncRuntime = null,

    /// The `SyncConfig` for a resolver attached to a versioned data source.
    sync_config: ?SyncConfig = null,

    /// The name of the `Type`.
    type_name: []const u8,

    pub const json_field_names = .{
        .api_id = "apiId",
        .caching_config = "cachingConfig",
        .code = "code",
        .data_source_name = "dataSourceName",
        .field_name = "fieldName",
        .kind = "kind",
        .max_batch_size = "maxBatchSize",
        .metrics_config = "metricsConfig",
        .pipeline_config = "pipelineConfig",
        .request_mapping_template = "requestMappingTemplate",
        .response_mapping_template = "responseMappingTemplate",
        .runtime = "runtime",
        .sync_config = "syncConfig",
        .type_name = "typeName",
    };
};

pub const CreateResolverOutput = struct {
    /// The `Resolver` object.
    resolver: ?Resolver = null,

    pub const json_field_names = .{
        .resolver = "resolver",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResolverInput, options: Options) !CreateResolverOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateResolverInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v1/apis/");
    try path_buf.appendSlice(alloc, input.api_id);
    try path_buf.appendSlice(alloc, "/types/");
    try path_buf.appendSlice(alloc, input.type_name);
    try path_buf.appendSlice(alloc, "/resolvers");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.caching_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"cachingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.code) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"code\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.data_source_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"dataSourceName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"fieldName\":");
    try aws.json.writeValue(@TypeOf(input.field_name), input.field_name, alloc, &body_buf);
    has_prev = true;
    if (input.kind) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"kind\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.max_batch_size) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"maxBatchSize\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.metrics_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"metricsConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.pipeline_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"pipelineConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.request_mapping_template) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"requestMappingTemplate\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.response_mapping_template) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"responseMappingTemplate\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.runtime) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"runtime\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.sync_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"syncConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateResolverOutput {
    var result: CreateResolverOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateResolverOutput, body, alloc);
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
