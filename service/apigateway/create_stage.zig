const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CacheClusterSize = @import("cache_cluster_size.zig").CacheClusterSize;
const CanarySettings = @import("canary_settings.zig").CanarySettings;
const AccessLogSettings = @import("access_log_settings.zig").AccessLogSettings;
const CacheClusterStatus = @import("cache_cluster_status.zig").CacheClusterStatus;
const MethodSetting = @import("method_setting.zig").MethodSetting;

pub const CreateStageInput = struct {
    /// Whether cache clustering is enabled for the stage.
    cache_cluster_enabled: ?bool = null,

    /// The stage's cache capacity in GB. For more information about choosing a
    /// cache size, see [Enabling API caching to enhance
    /// responsiveness](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html).
    cache_cluster_size: ?CacheClusterSize = null,

    /// The canary deployment settings of this stage.
    canary_settings: ?CanarySettings = null,

    /// The identifier of the Deployment resource for the Stage resource.
    deployment_id: []const u8,

    /// The description of the Stage resource.
    description: ?[]const u8 = null,

    /// The version of the associated API documentation.
    documentation_version: ?[]const u8 = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    /// The name for the Stage resource. Stage names can only contain alphanumeric
    /// characters, hyphens, and underscores. Maximum length is 128 characters.
    stage_name: []const u8,

    /// The key-value map of strings. The valid character set is [a-zA-Z+-=._:/].
    /// The tag key can be up to 128 characters and must not start with `aws:`. The
    /// tag value can be up to 256 characters.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies whether active tracing with X-ray is enabled for the Stage.
    tracing_enabled: ?bool = null,

    /// A map that defines the stage variables for the new Stage resource. Variable
    /// names
    /// can have alphanumeric and underscore characters, and the values must match
    /// `[A-Za-z0-9-._~:/?#&=,]+`.
    variables: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cache_cluster_enabled = "cacheClusterEnabled",
        .cache_cluster_size = "cacheClusterSize",
        .canary_settings = "canarySettings",
        .deployment_id = "deploymentId",
        .description = "description",
        .documentation_version = "documentationVersion",
        .rest_api_id = "restApiId",
        .stage_name = "stageName",
        .tags = "tags",
        .tracing_enabled = "tracingEnabled",
        .variables = "variables",
    };
};

pub const CreateStageOutput = @import("stage.zig").Stage;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStageInput, options: CallOptions) !CreateStageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/stages");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cache_cluster_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cacheClusterEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.cache_cluster_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cacheClusterSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.canary_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"canarySettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"deploymentId\":");
    try aws.json.writeValue(@TypeOf(input.deployment_id), input.deployment_id, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.documentation_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"documentationVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"stageName\":");
    try aws.json.writeValue(@TypeOf(input.stage_name), input.stage_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tracing_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tracingEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.variables) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"variables\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStageOutput {
    const result: CreateStageOutput = try aws.json.parseJsonObject(
        CreateStageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
