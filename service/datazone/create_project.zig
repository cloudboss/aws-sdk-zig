const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProjectMembershipAssignment = @import("project_membership_assignment.zig").ProjectMembershipAssignment;
const EnvironmentConfigurationUserParameter = @import("environment_configuration_user_parameter.zig").EnvironmentConfigurationUserParameter;
const EnvironmentDeploymentDetails = @import("environment_deployment_details.zig").EnvironmentDeploymentDetails;
const ProjectDeletionError = @import("project_deletion_error.zig").ProjectDeletionError;
const ProjectStatus = @import("project_status.zig").ProjectStatus;
const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const CreateProjectInput = struct {
    /// The description of the Amazon DataZone project.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which this project is created.
    domain_identifier: []const u8,

    /// The ID of the domain unit. This parameter is not required and if it is not
    /// specified, then the project is created at the root domain unit level.
    domain_unit_id: ?[]const u8 = null,

    /// The glossary terms that can be used in this Amazon DataZone project.
    glossary_terms: ?[]const []const u8 = null,

    /// The members to be assigned to the project.
    membership_assignments: ?[]const ProjectMembershipAssignment = null,

    /// The name of the Amazon DataZone project.
    name: []const u8,

    /// The category of the project. Set to 'ADMIN' designates this as an
    /// administrative project for the Amazon DataZone domain.
    project_category: ?[]const u8 = null,

    /// The default project IAM role that is used to access project resources and
    /// run computes such as Glue and Sagemaker.
    project_execution_role: ?[]const u8 = null,

    /// The ID of the project profile.
    project_profile_id: ?[]const u8 = null,

    /// The resource tags of the project.
    resource_tags: ?[]const aws.map.StringMapEntry = null,

    /// The user parameters of the project.
    user_parameters: ?[]const EnvironmentConfigurationUserParameter = null,

    pub const json_field_names = .{
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .domain_unit_id = "domainUnitId",
        .glossary_terms = "glossaryTerms",
        .membership_assignments = "membershipAssignments",
        .name = "name",
        .project_category = "projectCategory",
        .project_execution_role = "projectExecutionRole",
        .project_profile_id = "projectProfileId",
        .resource_tags = "resourceTags",
        .user_parameters = "userParameters",
    };
};

pub const CreateProjectOutput = struct {
    /// The timestamp of when the project was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the project.
    created_by: []const u8,

    /// The description of the project.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which the project was
    /// created.
    domain_id: []const u8,

    /// The ID of the domain unit.
    domain_unit_id: ?[]const u8 = null,

    /// The environment deployment details.
    environment_deployment_details: ?EnvironmentDeploymentDetails = null,

    /// Specifies the error message that is returned if the operation cannot be
    /// successfully completed.
    failure_reasons: ?[]const ProjectDeletionError = null,

    /// The glossary terms that can be used in the project.
    glossary_terms: ?[]const []const u8 = null,

    /// The ID of the Amazon DataZone project.
    id: []const u8,

    /// The timestamp of when the project was last updated.
    last_updated_at: ?i64 = null,

    /// The name of the project.
    name: []const u8,

    /// The category of the project.
    project_category: ?[]const u8 = null,

    /// The project profile ID.
    project_profile_id: ?[]const u8 = null,

    /// The status of the Amazon DataZone project that was created.
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
        .project_category = "projectCategory",
        .project_profile_id = "projectProfileId",
        .project_status = "projectStatus",
        .resource_tags = "resourceTags",
        .user_parameters = "userParameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProjectInput, options: CallOptions) !CreateProjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/projects");
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
    if (input.domain_unit_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"domainUnitId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.glossary_terms) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"glossaryTerms\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.membership_assignments) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"membershipAssignments\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.project_category) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"projectCategory\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.project_execution_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"projectExecutionRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.project_profile_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"projectProfileId\":");
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProjectOutput {
    const result: CreateProjectOutput = try aws.json.parseJsonObject(
        CreateProjectOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
