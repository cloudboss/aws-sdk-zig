const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CachingConfig = @import("caching_config.zig").CachingConfig;
const ResolverKind = @import("resolver_kind.zig").ResolverKind;
const ResolverLevelMetricsConfig = @import("resolver_level_metrics_config.zig").ResolverLevelMetricsConfig;
const PipelineConfig = @import("pipeline_config.zig").PipelineConfig;
const AppSyncRuntime = @import("app_sync_runtime.zig").AppSyncRuntime;
const SyncConfig = @import("sync_config.zig").SyncConfig;
const Resolver = @import("resolver.zig").Resolver;

pub const UpdateResolverInput = struct {
    /// The API ID.
    api_id: []const u8,

    /// The caching configuration for the resolver.
    caching_config: ?CachingConfig = null,

    /// The `resolver` code that contains the request and response functions. When
    /// code is used, the `runtime` is required. The `runtime` value must be
    /// `APPSYNC_JS`.
    code: ?[]const u8 = null,

    /// The new data source name.
    data_source_name: ?[]const u8 = null,

    /// The new field name.
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
    max_batch_size: ?i32 = null,

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

    /// The new request mapping template.
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

    /// The new response mapping template.
    response_mapping_template: ?[]const u8 = null,

    runtime: ?AppSyncRuntime = null,

    /// The `SyncConfig` for a resolver attached to a versioned data source.
    sync_config: ?SyncConfig = null,

    /// The new type name.
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

pub const UpdateResolverOutput = struct {
    /// The updated `Resolver` object.
    resolver: ?Resolver = null,

    pub const json_field_names = .{
        .resolver = "resolver",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateResolverInput, options: CallOptions) !UpdateResolverOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateResolverInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/types/");
    try path_buf.appendSlice(allocator, input.type_name);
    try path_buf.appendSlice(allocator, "/resolvers/");
    try path_buf.appendSlice(allocator, input.field_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.caching_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cachingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.code) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"code\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_source_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataSourceName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kind) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kind\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_batch_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxBatchSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metrics_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metricsConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pipeline_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"pipelineConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.request_mapping_template) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"requestMappingTemplate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.response_mapping_template) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"responseMappingTemplate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.runtime) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"runtime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sync_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"syncConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateResolverOutput {
    var result: UpdateResolverOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateResolverOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
