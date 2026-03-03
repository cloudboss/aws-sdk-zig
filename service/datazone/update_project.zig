const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EnvironmentDeploymentDetails = @import("environment_deployment_details.zig").EnvironmentDeploymentDetails;
const EnvironmentConfigurationUserParameter = @import("environment_configuration_user_parameter.zig").EnvironmentConfigurationUserParameter;
const ProjectDeletionError = @import("project_deletion_error.zig").ProjectDeletionError;
const ProjectStatus = @import("project_status.zig").ProjectStatus;
const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const UpdateProjectInput = struct {
    /// The description to be updated as part of the `UpdateProject` action.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain where a project is being updated.
    domain_identifier: []const u8,

    /// The ID of the domain unit.
    domain_unit_id: ?[]const u8 = null,

    /// The environment deployment details of the project.
    environment_deployment_details: ?EnvironmentDeploymentDetails = null,

    /// The glossary terms to be updated as part of the `UpdateProject` action.
    glossary_terms: ?[]const []const u8 = null,

    /// The identifier of the project that is to be updated.
    identifier: []const u8,

    /// The name to be updated as part of the `UpdateProject` action.
    name: ?[]const u8 = null,

    /// The project profile version to which the project should be updated. You can
    /// only specify the following string for this parameter: `latest`.
    project_profile_version: ?[]const u8 = null,

    /// The resource tags of the project.
    resource_tags: ?[]const aws.map.StringMapEntry = null,

    /// The user parameters of the project.
    user_parameters: ?[]const EnvironmentConfigurationUserParameter = null,

    pub const json_field_names = .{
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .domain_unit_id = "domainUnitId",
        .environment_deployment_details = "environmentDeploymentDetails",
        .glossary_terms = "glossaryTerms",
        .identifier = "identifier",
        .name = "name",
        .project_profile_version = "projectProfileVersion",
        .resource_tags = "resourceTags",
        .user_parameters = "userParameters",
    };
};

pub const UpdateProjectOutput = struct {
    /// The timestamp of when the project was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the project.
    created_by: []const u8,

    /// The description of the project that is to be updated.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which a project is updated.
    domain_id: []const u8,

    /// The ID of the domain unit.
    domain_unit_id: ?[]const u8 = null,

    /// The environment deployment details of the project.
    environment_deployment_details: ?EnvironmentDeploymentDetails = null,

    /// Specifies the error message that is returned if the operation cannot be
    /// successfully completed.
    failure_reasons: ?[]const ProjectDeletionError = null,

    /// The glossary terms of the project that are to be updated.
    glossary_terms: ?[]const []const u8 = null,

    /// The identifier of the project that is to be updated.
    id: []const u8,

    /// The timestamp of when the project was last updated.
    last_updated_at: ?i64 = null,

    /// The name of the project that is to be updated.
    name: []const u8,

    /// The ID of the project profile.
    project_profile_id: ?[]const u8 = null,

    /// The status of the project.
    project_status: ?ProjectStatus = null,

    /// The resource tags of the project.
    resource_tags: ?[]const ResourceTag = null,

    /// The user parameters of the project.
    user_parameters: ?[]const EnvironmentConfigurationUserParameter = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .domain_unit_id = "domainUnitId",
        .environment_deployment_details = "environmentDeploymentDetails",
        .failure_reasons = "failureReasons",
        .glossary_terms = "glossaryTerms",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .project_profile_id = "projectProfileId",
        .project_status = "projectStatus",
        .resource_tags = "resourceTags",
        .user_parameters = "userParameters",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProjectInput, options: Options) !UpdateProjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.domain_unit_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"domainUnitId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_deployment_details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentDeploymentDetails\":");
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
    if (input.project_profile_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"projectProfileVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceTags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProjectOutput {
    var result: UpdateProjectOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateProjectOutput, body, allocator);
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
