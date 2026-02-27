const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PatchOperation = @import("patch_operation.zig").PatchOperation;
const AccessLogSettings = @import("access_log_settings.zig").AccessLogSettings;
const CacheClusterSize = @import("cache_cluster_size.zig").CacheClusterSize;
const CacheClusterStatus = @import("cache_cluster_status.zig").CacheClusterStatus;
const CanarySettings = @import("canary_settings.zig").CanarySettings;
const MethodSetting = @import("method_setting.zig").MethodSetting;

pub const UpdateStageInput = struct {
    /// For more information about supported patch operations, see [Patch
    /// Operations](https://docs.aws.amazon.com/apigateway/latest/api/patch-operations.html).
    patch_operations: ?[]const PatchOperation = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    /// The name of the Stage resource to change information about.
    stage_name: []const u8,

    pub const json_field_names = .{
        .patch_operations = "patchOperations",
        .rest_api_id = "restApiId",
        .stage_name = "stageName",
    };
};

pub const UpdateStageOutput = struct {
    /// Settings for logging access in this stage.
    access_log_settings: ?AccessLogSettings = null,

    /// Specifies whether a cache cluster is enabled for the stage. To activate a
    /// method-level cache, set `CachingEnabled` to `true` for a method.
    cache_cluster_enabled: bool = false,

    /// The stage's cache capacity in GB. For more information about choosing a
    /// cache size, see [Enabling API caching to enhance
    /// responsiveness](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html).
    cache_cluster_size: ?CacheClusterSize = null,

    /// The status of the cache cluster for the stage, if enabled.
    cache_cluster_status: ?CacheClusterStatus = null,

    /// Settings for the canary deployment in this stage.
    canary_settings: ?CanarySettings = null,

    /// The identifier of a client certificate for an API stage.
    client_certificate_id: ?[]const u8 = null,

    /// The timestamp when the stage was created.
    created_date: ?i64 = null,

    /// The identifier of the Deployment that the stage points to.
    deployment_id: ?[]const u8 = null,

    /// The stage's description.
    description: ?[]const u8 = null,

    /// The version of the associated API documentation.
    documentation_version: ?[]const u8 = null,

    /// The timestamp when the stage last updated.
    last_updated_date: ?i64 = null,

    /// A map that defines the method settings for a Stage resource. Keys
    /// (designated as `/{method_setting_key` below) are method paths defined as
    /// `{resource_path}/{http_method}` for an individual method override, or
    /// `/\*/\*` for overriding all methods in the stage.
    method_settings: ?[]const aws.map.MapEntry(MethodSetting) = null,

    /// The name of the stage is the first path segment in the Uniform Resource
    /// Identifier (URI) of a call to API Gateway. Stage names can only contain
    /// alphanumeric characters, hyphens, and underscores. Maximum length is 128
    /// characters.
    stage_name: ?[]const u8 = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies whether active tracing with X-ray is enabled for the Stage.
    tracing_enabled: bool = false,

    /// A map that defines the stage variables for a Stage resource. Variable names
    /// can
    /// have alphanumeric and underscore characters, and the values must match
    /// `[A-Za-z0-9-._~:/?#&=,]+`.
    variables: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the WebAcl associated with the Stage.
    web_acl_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_log_settings = "accessLogSettings",
        .cache_cluster_enabled = "cacheClusterEnabled",
        .cache_cluster_size = "cacheClusterSize",
        .cache_cluster_status = "cacheClusterStatus",
        .canary_settings = "canarySettings",
        .client_certificate_id = "clientCertificateId",
        .created_date = "createdDate",
        .deployment_id = "deploymentId",
        .description = "description",
        .documentation_version = "documentationVersion",
        .last_updated_date = "lastUpdatedDate",
        .method_settings = "methodSettings",
        .stage_name = "stageName",
        .tags = "tags",
        .tracing_enabled = "tracingEnabled",
        .variables = "variables",
        .web_acl_arn = "webAclArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStageInput, options: Options) !UpdateStageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigateway");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateStageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/restapis/");
    try path_buf.appendSlice(alloc, input.rest_api_id);
    try path_buf.appendSlice(alloc, "/stages/");
    try path_buf.appendSlice(alloc, input.stage_name);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.patch_operations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"patchOperations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateStageOutput {
    var result: UpdateStageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateStageOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
