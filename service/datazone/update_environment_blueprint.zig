const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisioningProperties = @import("provisioning_properties.zig").ProvisioningProperties;
const CustomParameter = @import("custom_parameter.zig").CustomParameter;
const DeploymentProperties = @import("deployment_properties.zig").DeploymentProperties;

pub const UpdateEnvironmentBlueprintInput = struct {
    /// The description to be updated as part of the `UpdateEnvironmentBlueprint`
    /// action.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which an environment
    /// blueprint is to be updated.
    domain_identifier: []const u8,

    /// The identifier of the environment blueprint to be updated.
    identifier: []const u8,

    /// The provisioning properties to be updated as part of the
    /// `UpdateEnvironmentBlueprint` action.
    provisioning_properties: ?ProvisioningProperties = null,

    /// The user parameters to be updated as part of the
    /// `UpdateEnvironmentBlueprint` action.
    user_parameters: ?[]const CustomParameter = null,

    pub const json_field_names = .{
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .provisioning_properties = "provisioningProperties",
        .user_parameters = "userParameters",
    };
};

pub const UpdateEnvironmentBlueprintOutput = struct {
    /// The timestamp of when the environment blueprint was created.
    created_at: ?i64 = null,

    /// The deployment properties to be updated as part of the
    /// `UpdateEnvironmentBlueprint` action.
    deployment_properties: ?DeploymentProperties = null,

    /// The description to be updated as part of the `UpdateEnvironmentBlueprint`
    /// action.
    description: ?[]const u8 = null,

    /// The glossary terms to be updated as part of the `UpdateEnvironmentBlueprint`
    /// action.
    glossary_terms: ?[]const []const u8 = null,

    /// The identifier of the blueprint to be updated.
    id: []const u8,

    /// The name to be updated as part of the `UpdateEnvironmentBlueprint` action.
    name: []const u8,

    /// The provider of the blueprint to be udpated.
    provider: []const u8,

    /// The provisioning properties to be updated as part of the
    /// `UpdateEnvironmentBlueprint` action.
    provisioning_properties: ?ProvisioningProperties = null,

    /// The timestamp of when the blueprint was updated.
    updated_at: ?i64 = null,

    /// The user parameters to be updated as part of the
    /// `UpdateEnvironmentBlueprint` action.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEnvironmentBlueprintInput, options: CallOptions) !UpdateEnvironmentBlueprintOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEnvironmentBlueprintInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environment-blueprints/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.provisioning_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"provisioningProperties\":");
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

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEnvironmentBlueprintOutput {
    var result: UpdateEnvironmentBlueprintOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateEnvironmentBlueprintOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
