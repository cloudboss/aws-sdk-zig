const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CacheClusterSize = @import("cache_cluster_size.zig").CacheClusterSize;
const DeploymentCanarySettings = @import("deployment_canary_settings.zig").DeploymentCanarySettings;
const MethodSnapshot = @import("method_snapshot.zig").MethodSnapshot;

pub const CreateDeploymentInput = struct {
    /// Enables a cache cluster for the Stage resource specified in the input.
    cache_cluster_enabled: ?bool = null,

    /// The stage's cache capacity in GB. For more information about choosing a
    /// cache size, see [Enabling API caching to enhance
    /// responsiveness](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html).
    cache_cluster_size: ?CacheClusterSize = null,

    /// The input configuration for the canary deployment when the deployment is a
    /// canary release deployment.
    canary_settings: ?DeploymentCanarySettings = null,

    /// The description for the Deployment resource to create.
    description: ?[]const u8 = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    /// The description of the Stage resource for the Deployment resource to create.
    stage_description: ?[]const u8 = null,

    /// The name of the Stage resource for the Deployment resource to create.
    stage_name: ?[]const u8 = null,

    /// Specifies whether active tracing with X-ray is enabled for the Stage.
    tracing_enabled: ?bool = null,

    /// A map that defines the stage variables for the Stage resource that is
    /// associated
    /// with the new deployment. Variable names can have alphanumeric and underscore
    /// characters, and the values
    /// must match `[A-Za-z0-9-._~:/?#&=,]+`.
    variables: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cache_cluster_enabled = "cacheClusterEnabled",
        .cache_cluster_size = "cacheClusterSize",
        .canary_settings = "canarySettings",
        .description = "description",
        .rest_api_id = "restApiId",
        .stage_description = "stageDescription",
        .stage_name = "stageName",
        .tracing_enabled = "tracingEnabled",
        .variables = "variables",
    };
};

pub const CreateDeploymentOutput = @import("deployment.zig").Deployment;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeploymentInput, options: CallOptions) !CreateDeploymentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/deployments");
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
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stage_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stageDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stage_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stageName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeploymentOutput {
    const result: CreateDeploymentOutput = try aws.json.parseJsonObject(
        CreateDeploymentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
