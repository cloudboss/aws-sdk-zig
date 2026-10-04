const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisioningConfiguration = @import("provisioning_configuration.zig").ProvisioningConfiguration;

pub const GetEnvironmentBlueprintConfigurationInput = struct {
    /// The ID of the Amazon DataZone domain where this blueprint exists.
    domain_identifier: []const u8,

    /// He ID of the blueprint.
    environment_blueprint_identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .environment_blueprint_identifier = "environmentBlueprintIdentifier",
    };
};

pub const GetEnvironmentBlueprintConfigurationOutput = struct {
    /// The timestamp of when this blueprint was created.
    created_at: ?i64 = null,

    /// The ID of the Amazon DataZone domain where this blueprint exists.
    domain_id: []const u8,

    /// The Amazon Web Services regions in which this blueprint is enabled.
    enabled_regions: ?[]const []const u8 = null,

    /// The ID of the blueprint.
    environment_blueprint_id: []const u8,

    /// The environment role permissions boundary.
    environment_role_permission_boundary: ?[]const u8 = null,

    /// The ARN of the manage access role with which this blueprint is created.
    manage_access_role_arn: ?[]const u8 = null,

    /// The provisioning configuration of a blueprint.
    provisioning_configurations: ?[]const ProvisioningConfiguration = null,

    /// The ARN of the provisioning role with which this blueprint is created.
    provisioning_role_arn: ?[]const u8 = null,

    /// The regional parameters of the blueprint.
    regional_parameters: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    /// The timestamp of when this blueprint was upated.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEnvironmentBlueprintConfigurationInput, options: CallOptions) !GetEnvironmentBlueprintConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEnvironmentBlueprintConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environment-blueprint-configurations/");
    try path_buf.appendSlice(allocator, input.environment_blueprint_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEnvironmentBlueprintConfigurationOutput {
    var result: GetEnvironmentBlueprintConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEnvironmentBlueprintConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
