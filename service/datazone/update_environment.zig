const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EnvironmentParameter = @import("environment_parameter.zig").EnvironmentParameter;
const DeploymentProperties = @import("deployment_properties.zig").DeploymentProperties;
const ConfigurableEnvironmentAction = @import("configurable_environment_action.zig").ConfigurableEnvironmentAction;
const Deployment = @import("deployment.zig").Deployment;
const Resource = @import("resource.zig").Resource;
const ProvisioningProperties = @import("provisioning_properties.zig").ProvisioningProperties;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;
const CustomParameter = @import("custom_parameter.zig").CustomParameter;

pub const UpdateEnvironmentInput = struct {
    /// The blueprint version to which the environment should be updated. You can
    /// only specify the following string for this parameter: `latest`.
    blueprint_version: ?[]const u8 = null,

    /// The description to be updated as part of the `UpdateEnvironment` action.
    description: ?[]const u8 = null,

    /// The identifier of the domain in which the environment is to be updated.
    domain_identifier: []const u8,

    /// The configuration name of the environment.
    environment_configuration_name: ?[]const u8 = null,

    /// The glossary terms to be updated as part of the `UpdateEnvironment` action.
    glossary_terms: ?[]const []const u8 = null,

    /// The identifier of the environment that is to be updated.
    identifier: []const u8,

    /// The name to be updated as part of the `UpdateEnvironment` action.
    name: ?[]const u8 = null,

    /// The user parameters of the environment.
    user_parameters: ?[]const EnvironmentParameter = null,

    pub const json_field_names = .{
        .blueprint_version = "blueprintVersion",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .environment_configuration_name = "environmentConfigurationName",
        .glossary_terms = "glossaryTerms",
        .identifier = "identifier",
        .name = "name",
        .user_parameters = "userParameters",
    };
};

pub const UpdateEnvironmentOutput = struct {
    /// The identifier of the Amazon Web Services account in which the environment
    /// is to be updated.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services Region in which the environment is updated.
    aws_account_region: ?[]const u8 = null,

    /// The timestamp of when the environment was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the environment.
    created_by: []const u8,

    /// The deployment properties to be updated as part of the `UpdateEnvironment`
    /// action.
    deployment_properties: ?DeploymentProperties = null,

    /// The description to be updated as part of the `UpdateEnvironment` action.
    description: ?[]const u8 = null,

    /// The identifier of the domain in which the environment is to be updated.
    domain_id: []const u8,

    /// The environment actions to be updated as part of the `UpdateEnvironment`
    /// action.
    environment_actions: ?[]const ConfigurableEnvironmentAction = null,

    /// The blueprint identifier of the environment.
    environment_blueprint_id: ?[]const u8 = null,

    /// The configuration ID of the environment.
    environment_configuration_id: ?[]const u8 = null,

    /// The configuration name of the environment.
    environment_configuration_name: ?[]const u8 = null,

    /// The profile identifier of the environment.
    environment_profile_id: ?[]const u8 = null,

    /// The glossary terms to be updated as part of the `UpdateEnvironment` action.
    glossary_terms: ?[]const []const u8 = null,

    /// The identifier of the environment that is to be updated.
    id: ?[]const u8 = null,

    /// The last deployment of the environment.
    last_deployment: ?Deployment = null,

    /// The name to be updated as part of the `UpdateEnvironment` action.
    name: []const u8,

    /// The project identifier of the environment.
    project_id: []const u8,

    /// The provider identifier of the environment.
    provider: []const u8,

    /// The provisioned resources to be updated as part of the `UpdateEnvironment`
    /// action.
    provisioned_resources: ?[]const Resource = null,

    /// The provisioning properties to be updated as part of the `UpdateEnvironment`
    /// action.
    provisioning_properties: ?ProvisioningProperties = null,

    /// The status to be updated as part of the `UpdateEnvironment` action.
    status: ?EnvironmentStatus = null,

    /// The timestamp of when the environment was updated.
    updated_at: ?i64 = null,

    /// The user parameters to be updated as part of the `UpdateEnvironment` action.
    user_parameters: ?[]const CustomParameter = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .aws_account_region = "awsAccountRegion",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .deployment_properties = "deploymentProperties",
        .description = "description",
        .domain_id = "domainId",
        .environment_actions = "environmentActions",
        .environment_blueprint_id = "environmentBlueprintId",
        .environment_configuration_id = "environmentConfigurationId",
        .environment_configuration_name = "environmentConfigurationName",
        .environment_profile_id = "environmentProfileId",
        .glossary_terms = "glossaryTerms",
        .id = "id",
        .last_deployment = "lastDeployment",
        .name = "name",
        .project_id = "projectId",
        .provider = "provider",
        .provisioned_resources = "provisionedResources",
        .provisioning_properties = "provisioningProperties",
        .status = "status",
        .updated_at = "updatedAt",
        .user_parameters = "userParameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEnvironmentInput, options: CallOptions) !UpdateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datazone");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.blueprint_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blueprintVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_configuration_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentConfigurationName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.glossary_terms) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"glossaryTerms\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userParameters\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEnvironmentOutput {
    var result: UpdateEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateEnvironmentOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
