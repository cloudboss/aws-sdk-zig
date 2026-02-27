const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ProvisioningConfiguration = @import("provisioning_configuration.zig").ProvisioningConfiguration;

pub const PutEnvironmentBlueprintConfigurationInput = struct {
    /// The identifier of the Amazon DataZone domain.
    domain_identifier: []const u8,

    /// Specifies the enabled Amazon Web Services Regions.
    enabled_regions: []const []const u8,

    /// The identifier of the environment blueprint.
    environment_blueprint_identifier: []const u8,

    /// The environment role permissions boundary.
    environment_role_permission_boundary: ?[]const u8 = null,

    /// Region-agnostic environment blueprint parameters.
    global_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the manage access role.
    manage_access_role_arn: ?[]const u8 = null,

    /// The provisioning configuration of a blueprint.
    provisioning_configurations: ?[]const ProvisioningConfiguration = null,

    /// The ARN of the provisioning role.
    provisioning_role_arn: ?[]const u8 = null,

    /// The regional parameters in the environment blueprint.
    regional_parameters: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .enabled_regions = "enabledRegions",
        .environment_blueprint_identifier = "environmentBlueprintIdentifier",
        .environment_role_permission_boundary = "environmentRolePermissionBoundary",
        .global_parameters = "globalParameters",
        .manage_access_role_arn = "manageAccessRoleArn",
        .provisioning_configurations = "provisioningConfigurations",
        .provisioning_role_arn = "provisioningRoleArn",
        .regional_parameters = "regionalParameters",
    };
};

pub const PutEnvironmentBlueprintConfigurationOutput = struct {
    /// The timestamp of when the environment blueprint was created.
    created_at: ?i64 = null,

    /// The identifier of the Amazon DataZone domain.
    domain_id: []const u8,

    /// Specifies the enabled Amazon Web Services Regions.
    enabled_regions: ?[]const []const u8 = null,

    /// The identifier of the environment blueprint.
    environment_blueprint_id: []const u8,

    /// The environment role permissions boundary.
    environment_role_permission_boundary: ?[]const u8 = null,

    /// The ARN of the manage access role.
    manage_access_role_arn: ?[]const u8 = null,

    /// The provisioning configuration of a blueprint.
    provisioning_configurations: ?[]const ProvisioningConfiguration = null,

    /// The ARN of the provisioning role.
    provisioning_role_arn: ?[]const u8 = null,

    /// The regional parameters in the environment blueprint.
    regional_parameters: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    /// The timestamp of when the environment blueprint was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .domain_id = "domainId",
        .enabled_regions = "enabledRegions",
        .environment_blueprint_id = "environmentBlueprintId",
        .environment_role_permission_boundary = "environmentRolePermissionBoundary",
        .manage_access_role_arn = "manageAccessRoleArn",
        .provisioning_configurations = "provisioningConfigurations",
        .provisioning_role_arn = "provisioningRoleArn",
        .regional_parameters = "regionalParameters",
        .updated_at = "updatedAt",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutEnvironmentBlueprintConfigurationInput, options: Options) !PutEnvironmentBlueprintConfigurationOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutEnvironmentBlueprintConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v2/domains/");
    try path_buf.appendSlice(alloc, input.domain_identifier);
    try path_buf.appendSlice(alloc, "/environment-blueprint-configurations/");
    try path_buf.appendSlice(alloc, input.environment_blueprint_identifier);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"enabledRegions\":");
    try aws.json.writeValue(@TypeOf(input.enabled_regions), input.enabled_regions, alloc, &body_buf);
    has_prev = true;
    if (input.environment_role_permission_boundary) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"environmentRolePermissionBoundary\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.global_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"globalParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.manage_access_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"manageAccessRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.provisioning_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"provisioningConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.provisioning_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"provisioningRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.regional_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"regionalParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutEnvironmentBlueprintConfigurationOutput {
    var result: PutEnvironmentBlueprintConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutEnvironmentBlueprintConfigurationOutput, body, alloc);
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
