const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentProperties = @import("deployment_properties.zig").DeploymentProperties;
const ProvisioningProperties = @import("provisioning_properties.zig").ProvisioningProperties;
const CustomParameter = @import("custom_parameter.zig").CustomParameter;

pub const GetEnvironmentBlueprintInput = struct {
    /// The identifier of the domain in which this blueprint exists.
    domain_identifier: []const u8,

    /// The ID of this Amazon DataZone blueprint.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetEnvironmentBlueprintOutput = struct {
    /// A timestamp of when this blueprint was created.
    created_at: ?i64 = null,

    /// The deployment properties of this Amazon DataZone blueprint.
    deployment_properties: ?DeploymentProperties = null,

    /// The description of this Amazon DataZone blueprint.
    description: ?[]const u8 = null,

    /// The glossary terms attached to this Amazon DataZone blueprint.
    glossary_terms: ?[]const []const u8 = null,

    /// The ID of this Amazon DataZone blueprint.
    id: []const u8,

    /// The name of this Amazon DataZone blueprint.
    name: []const u8,

    /// The provider of this Amazon DataZone blueprint.
    provider: []const u8,

    /// The provisioning properties of this Amazon DataZone blueprint.
    provisioning_properties: ?ProvisioningProperties = null,

    /// The timestamp of when this blueprint was updated.
    updated_at: ?i64 = null,

    /// The user parameters of this blueprint.
    user_parameters: ?[]const CustomParameter = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .deployment_properties = "deploymentProperties",
        .description = "description",
        .glossary_terms = "glossaryTerms",
        .id = "id",
        .name = "name",
        .provider = "provider",
        .provisioning_properties = "provisioningProperties",
        .updated_at = "updatedAt",
        .user_parameters = "userParameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEnvironmentBlueprintInput, options: CallOptions) !GetEnvironmentBlueprintOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEnvironmentBlueprintInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environment-blueprints/");
    try path_buf.appendSlice(allocator, input.identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEnvironmentBlueprintOutput {
    var result: GetEnvironmentBlueprintOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEnvironmentBlueprintOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
