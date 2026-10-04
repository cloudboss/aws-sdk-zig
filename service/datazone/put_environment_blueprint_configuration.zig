const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutEnvironmentBlueprintConfigurationInput, options: CallOptions) !PutEnvironmentBlueprintConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutEnvironmentBlueprintConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environment-blueprint-configurations/");
    try path_buf.appendSlice(allocator, input.environment_blueprint_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"enabledRegions\":");
    try aws.json.writeValue(@TypeOf(input.enabled_regions), input.enabled_regions, allocator, &body_buf);
    has_prev = true;
    if (input.environment_role_permission_boundary) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentRolePermissionBoundary\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.global_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"globalParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.manage_access_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"manageAccessRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.provisioning_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"provisioningConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.provisioning_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"provisioningRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.regional_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"regionalParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutEnvironmentBlueprintConfigurationOutput {
    var result: PutEnvironmentBlueprintConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutEnvironmentBlueprintConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
