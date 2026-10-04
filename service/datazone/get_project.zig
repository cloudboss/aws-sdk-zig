const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentDeploymentDetails = @import("environment_deployment_details.zig").EnvironmentDeploymentDetails;
const ProjectDeletionError = @import("project_deletion_error.zig").ProjectDeletionError;
const ProjectStatus = @import("project_status.zig").ProjectStatus;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const EnvironmentConfigurationUserParameter = @import("environment_configuration_user_parameter.zig").EnvironmentConfigurationUserParameter;

pub const GetProjectInput = struct {
    /// The ID of the Amazon DataZone domain in which the project exists.
    domain_identifier: []const u8,

    /// The ID of the project.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetProjectOutput = struct {
    /// The timestamp of when the project was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the project.
    created_by: []const u8,

    /// The description of the project.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the project exists.
    domain_id: []const u8,

    /// The ID of the domain unit.
    domain_unit_id: ?[]const u8 = null,

    /// The environment deployment status of a project.
    environment_deployment_details: ?EnvironmentDeploymentDetails = null,

    /// Specifies the error message that is returned if the operation cannot be
    /// successfully completed.
    failure_reasons: ?[]const ProjectDeletionError = null,

    /// The business glossary terms that can be used in the project.
    glossary_terms: ?[]const []const u8 = null,

    /// >The ID of the project.
    id: []const u8,

    /// The timestamp of when the project was last updated.
    last_updated_at: ?i64 = null,

    /// The name of the project.
    name: []const u8,

    /// The category of the project.
    project_category: ?[]const u8 = null,

    /// The ID of the project profile of a project.
    project_profile_id: ?[]const u8 = null,

    /// The status of the project.
    project_status: ?ProjectStatus = null,

    /// The resource tags of the project.
    resource_tags: ?[]const ResourceTag = null,

    /// The user parameters of a project.
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
        .project_category = "projectCategory",
        .project_profile_id = "projectProfileId",
        .project_status = "projectStatus",
        .resource_tags = "resourceTags",
        .user_parameters = "userParameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProjectInput, options: CallOptions) !GetProjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/projects/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProjectOutput {
    const result: GetProjectOutput = try aws.json.parseJsonObject(
        GetProjectOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
