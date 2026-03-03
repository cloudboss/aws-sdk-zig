const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AccessLogSettings = @import("access_log_settings.zig").AccessLogSettings;
const RouteSettings = @import("route_settings.zig").RouteSettings;

pub const UpdateStageInput = struct {
    /// Settings for logging access in this stage.
    access_log_settings: ?AccessLogSettings = null,

    /// The API identifier.
    api_id: []const u8,

    /// Specifies whether updates to an API automatically trigger a new deployment.
    /// The default value is false.
    auto_deploy: ?bool = null,

    /// The identifier of a client certificate for a Stage.
    client_certificate_id: ?[]const u8 = null,

    /// The default route settings for the stage.
    default_route_settings: ?RouteSettings = null,

    /// The deployment identifier for the API stage. Can't be updated if autoDeploy
    /// is enabled.
    deployment_id: ?[]const u8 = null,

    /// The description for the API stage.
    description: ?[]const u8 = null,

    /// Route settings for the stage.
    route_settings: ?[]const aws.map.MapEntry(RouteSettings) = null,

    /// The stage name. Stage names can contain only alphanumeric characters,
    /// hyphens, and underscores, or be $default. Maximum length is 128 characters.
    stage_name: []const u8,

    /// A map that defines the stage variables for a Stage. Variable names can have
    /// alphanumeric and underscore characters, and the values must match
    /// [A-Za-z0-9-._~:/?#&=,]+.
    stage_variables: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .access_log_settings = "AccessLogSettings",
        .api_id = "ApiId",
        .auto_deploy = "AutoDeploy",
        .client_certificate_id = "ClientCertificateId",
        .default_route_settings = "DefaultRouteSettings",
        .deployment_id = "DeploymentId",
        .description = "Description",
        .route_settings = "RouteSettings",
        .stage_name = "StageName",
        .stage_variables = "StageVariables",
    };
};

pub const UpdateStageOutput = struct {
    /// Settings for logging access in this stage.
    access_log_settings: ?AccessLogSettings = null,

    /// Specifies whether a stage is managed by API Gateway. If you created an API
    /// using quick create, the $default stage is managed by API Gateway. You can't
    /// modify the $default stage.
    api_gateway_managed: ?bool = null,

    /// Specifies whether updates to an API automatically trigger a new deployment.
    /// The default value is false.
    auto_deploy: ?bool = null,

    /// The identifier of a client certificate for a Stage. Supported only for
    /// WebSocket APIs.
    client_certificate_id: ?[]const u8 = null,

    /// The timestamp when the stage was created.
    created_date: ?i64 = null,

    /// Default route settings for the stage.
    default_route_settings: ?RouteSettings = null,

    /// The identifier of the Deployment that the Stage is associated with. Can't be
    /// updated if autoDeploy is enabled.
    deployment_id: ?[]const u8 = null,

    /// The description of the stage.
    description: ?[]const u8 = null,

    /// Describes the status of the last deployment of a stage. Supported only for
    /// stages with autoDeploy enabled.
    last_deployment_status_message: ?[]const u8 = null,

    /// The timestamp when the stage was last updated.
    last_updated_date: ?i64 = null,

    /// Route settings for the stage, by routeKey.
    route_settings: ?[]const aws.map.MapEntry(RouteSettings) = null,

    /// The name of the stage.
    stage_name: ?[]const u8 = null,

    /// A map that defines the stage variables for a stage resource. Variable names
    /// can have alphanumeric and underscore characters, and the values must match
    /// [A-Za-z0-9-._~:/?#&=,]+.
    stage_variables: ?[]const aws.map.StringMapEntry = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .access_log_settings = "AccessLogSettings",
        .api_gateway_managed = "ApiGatewayManaged",
        .auto_deploy = "AutoDeploy",
        .client_certificate_id = "ClientCertificateId",
        .created_date = "CreatedDate",
        .default_route_settings = "DefaultRouteSettings",
        .deployment_id = "DeploymentId",
        .description = "Description",
        .last_deployment_status_message = "LastDeploymentStatusMessage",
        .last_updated_date = "LastUpdatedDate",
        .route_settings = "RouteSettings",
        .stage_name = "StageName",
        .stage_variables = "StageVariables",
        .tags = "Tags",
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigatewayv2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigatewayv2", "ApiGatewayV2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/stages/");
    try path_buf.appendSlice(allocator, input.stage_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.access_log_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccessLogSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_deploy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AutoDeploy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_certificate_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientCertificateId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.default_route_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DefaultRouteSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.deployment_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeploymentId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.route_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RouteSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stage_variables) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StageVariables\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStageOutput {
    var result: UpdateStageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateStageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
