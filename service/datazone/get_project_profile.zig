const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentConfiguration = @import("environment_configuration.zig").EnvironmentConfiguration;
const ResourceTagParameter = @import("resource_tag_parameter.zig").ResourceTagParameter;
const Status = @import("status.zig").Status;

pub const GetProjectProfileInput = struct {
    /// The ID of the domain.
    domain_identifier: []const u8,

    /// The ID of the project profile.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetProjectProfileOutput = struct {
    /// Specifies whether custom project resource tags are supported.
    allow_custom_project_resource_tags: ?bool = null,

    /// The timestamp of when the project profile was created.
    created_at: ?i64 = null,

    /// The user who created the project profile.
    created_by: []const u8,

    /// The description of the project profile.
    description: ?[]const u8 = null,

    /// The ID of the domain of the project profile.
    domain_id: []const u8,

    /// The ID of the domain unit of the project profile.
    domain_unit_id: ?[]const u8 = null,

    /// The environment configurations of the project profile.
    environment_configurations: ?[]const EnvironmentConfiguration = null,

    /// The ID of the project profile.
    id: []const u8,

    /// The timestamp of when project profile was last updated.
    last_updated_at: ?i64 = null,

    /// The name of the project profile.
    name: []const u8,

    /// The resource tags of the project profile.
    project_resource_tags: ?[]const ResourceTagParameter = null,

    /// Field viewable through the UI that provides a project user with the allowed
    /// resource tag specifications.
    project_resource_tags_description: ?[]const u8 = null,

    /// The status of the project profile.
    status: ?Status = null,

    pub const json_field_names = .{
        .allow_custom_project_resource_tags = "allowCustomProjectResourceTags",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .domain_unit_id = "domainUnitId",
        .environment_configurations = "environmentConfigurations",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .project_resource_tags = "projectResourceTags",
        .project_resource_tags_description = "projectResourceTagsDescription",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProjectProfileInput, options: CallOptions) !GetProjectProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProjectProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/project-profiles/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProjectProfileOutput {
    var result: GetProjectProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetProjectProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
