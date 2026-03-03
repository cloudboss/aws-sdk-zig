const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EnvironmentParameter = @import("environment_parameter.zig").EnvironmentParameter;
const DeploymentProperties = @import("deployment_properties.zig").DeploymentProperties;
const ConfigurableEnvironmentAction = @import("configurable_environment_action.zig").ConfigurableEnvironmentAction;
const Deployment = @import("deployment.zig").Deployment;
const Resource = @import("resource.zig").Resource;
const ProvisioningProperties = @import("provisioning_properties.zig").ProvisioningProperties;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;
const CustomParameter = @import("custom_parameter.zig").CustomParameter;

pub const CreateEnvironmentInput = struct {
    /// The deployment order of the environment.
    deployment_order: ?i32 = null,

    /// The description of the Amazon DataZone environment.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which the environment is
    /// created.
    domain_identifier: []const u8,

    /// The ID of the account in which the environment is being created.
    environment_account_identifier: ?[]const u8 = null,

    /// The region of the account in which the environment is being created.
    environment_account_region: ?[]const u8 = null,

    /// The ID of the blueprint with which the environment is being created.
    environment_blueprint_identifier: ?[]const u8 = null,

    /// The configuration ID of the environment.
    environment_configuration_id: ?[]const u8 = null,

    /// The identifier of the environment profile that is used to create this Amazon
    /// DataZone environment.
    environment_profile_identifier: ?[]const u8 = null,

    /// The glossary terms that can be used in this Amazon DataZone environment.
    glossary_terms: ?[]const []const u8 = null,

    /// The name of the Amazon DataZone environment.
    name: []const u8,

    /// The identifier of the Amazon DataZone project in which this environment is
    /// created.
    project_identifier: []const u8,

    /// The user parameters of this Amazon DataZone environment.
    user_parameters: ?[]const EnvironmentParameter = null,

    pub const json_field_names = .{
        .deployment_order = "deploymentOrder",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .environment_account_identifier = "environmentAccountIdentifier",
        .environment_account_region = "environmentAccountRegion",
        .environment_blueprint_identifier = "environmentBlueprintIdentifier",
        .environment_configuration_id = "environmentConfigurationId",
        .environment_profile_identifier = "environmentProfileIdentifier",
        .glossary_terms = "glossaryTerms",
        .name = "name",
        .project_identifier = "projectIdentifier",
        .user_parameters = "userParameters",
    };
};

pub const CreateEnvironmentOutput = struct {
    /// The Amazon Web Services account in which the Amazon DataZone environment is
    /// created.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services region in which the Amazon DataZone environment is
    /// created.
    aws_account_region: ?[]const u8 = null,

    /// The timestamp of when the environment was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created this environment.
    created_by: []const u8,

    /// The deployment properties of this Amazon DataZone environment.
    deployment_properties: ?DeploymentProperties = null,

    /// The description of this Amazon DataZone environment.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which the environment is
    /// created.
    domain_id: []const u8,

    /// The configurable actions of this Amazon DataZone environment.
    environment_actions: ?[]const ConfigurableEnvironmentAction = null,

    /// The ID of the blueprint with which this Amazon DataZone environment was
    /// created.
    environment_blueprint_id: ?[]const u8 = null,

    /// The configuration ID of the environment.
    environment_configuration_id: ?[]const u8 = null,

    /// The ID of the environment profile with which this Amazon DataZone
    /// environment was created.
    environment_profile_id: ?[]const u8 = null,

    /// The glossary terms that can be used in this Amazon DataZone environment.
    glossary_terms: ?[]const []const u8 = null,

    /// The ID of this Amazon DataZone environment.
    id: ?[]const u8 = null,

    /// The details of the last deployment of this Amazon DataZone environment.
    last_deployment: ?Deployment = null,

    /// The name of this environment.
    name: []const u8,

    /// The ID of the Amazon DataZone project in which this environment is created.
    project_id: []const u8,

    /// The provider of this Amazon DataZone environment.
    provider: []const u8,

    /// The provisioned resources of this Amazon DataZone environment.
    provisioned_resources: ?[]const Resource = null,

    /// The provisioning properties of this Amazon DataZone environment.
    provisioning_properties: ?ProvisioningProperties = null,

    /// The status of this Amazon DataZone environment.
    status: ?EnvironmentStatus = null,

    /// The timestamp of when this environment was updated.
    updated_at: ?i64 = null,

    /// The user parameters of this Amazon DataZone environment.
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentInput, options: Options) !CreateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environments");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.deployment_order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deploymentOrder\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_account_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentAccountIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_account_region) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentAccountRegion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_blueprint_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentBlueprintIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_configuration_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentConfigurationId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_profile_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentProfileIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.glossary_terms) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"glossaryTerms\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"projectIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.project_identifier), input.project_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.user_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentOutput {
    var result: CreateEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateEnvironmentOutput, body, allocator);
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
