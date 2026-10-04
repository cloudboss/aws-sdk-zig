const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BlueprintCategory = @import("blueprint_category.zig").BlueprintCategory;
const ProvisioningProperties = @import("provisioning_properties.zig").ProvisioningProperties;
const CustomParameter = @import("custom_parameter.zig").CustomParameter;
const DeploymentProperties = @import("deployment_properties.zig").DeploymentProperties;

pub const CreateEnvironmentBlueprintInput = struct {
    /// The category of the Amazon DataZone blueprint. The only valid value is
    /// `TOOLING`, which creates a blueprint that provisions the tooling resources
    /// of a project.
    blueprint_category: ?BlueprintCategory = null,

    /// The description of the Amazon DataZone blueprint.
    description: ?[]const u8 = null,

    /// The identifier of the domain in which this blueprint is created.
    domain_identifier: []const u8,

    /// The name of this Amazon DataZone blueprint.
    name: []const u8,

    /// The provisioning properties of this Amazon DataZone blueprint.
    provisioning_properties: ProvisioningProperties,

    /// The user parameters of this Amazon DataZone blueprint.
    user_parameters: ?[]const CustomParameter = null,

    pub const json_field_names = .{
        .blueprint_category = "blueprintCategory",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .name = "name",
        .provisioning_properties = "provisioningProperties",
        .user_parameters = "userParameters",
    };
};

pub const CreateEnvironmentBlueprintOutput = struct {
    /// The category of the Amazon DataZone blueprint. The only valid value is
    /// `TOOLING`, which indicates a blueprint that provisions the tooling resources
    /// of a project.
    blueprint_category: ?BlueprintCategory = null,

    /// The timestamp at which the environment blueprint was created.
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

    /// The user parameters of this Amazon DataZone blueprint.
    user_parameters: ?[]const CustomParameter = null,

    pub const json_field_names = .{
        .blueprint_category = "blueprintCategory",
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentBlueprintInput, options: CallOptions) !CreateEnvironmentBlueprintOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentBlueprintInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environment-blueprints");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.blueprint_category) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blueprintCategory\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"provisioningProperties\":");
    try aws.json.writeValue(@TypeOf(input.provisioning_properties), input.provisioning_properties, allocator, &body_buf);
    has_prev = true;
    if (input.user_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentBlueprintOutput {
    const result: CreateEnvironmentBlueprintOutput = try aws.json.parseJsonObject(
        CreateEnvironmentBlueprintOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
