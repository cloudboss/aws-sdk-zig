const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentConfiguration = @import("environment_configuration.zig").EnvironmentConfiguration;
const ResourceTagParameter = @import("resource_tag_parameter.zig").ResourceTagParameter;
const Status = @import("status.zig").Status;

pub const CreateProjectProfileInput = struct {
    /// Specifies whether custom project resource tags are supported.
    allow_custom_project_resource_tags: ?bool = null,

    /// A description of a project profile.
    description: ?[]const u8 = null,

    /// A domain ID of the project profile.
    domain_identifier: []const u8,

    /// A domain unit ID of the project profile.
    domain_unit_identifier: ?[]const u8 = null,

    /// Environment configurations of the project profile.
    environment_configurations: ?[]const EnvironmentConfiguration = null,

    /// Project profile name.
    name: []const u8,

    /// The resource tags of the project profile.
    project_resource_tags: ?[]const ResourceTagParameter = null,

    /// Field viewable through the UI that provides a project user with the allowed
    /// resource tag specifications.
    project_resource_tags_description: ?[]const u8 = null,

    /// Project profile status.
    status: ?Status = null,

    pub const json_field_names = .{
        .allow_custom_project_resource_tags = "allowCustomProjectResourceTags",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .domain_unit_identifier = "domainUnitIdentifier",
        .environment_configurations = "environmentConfigurations",
        .name = "name",
        .project_resource_tags = "projectResourceTags",
        .project_resource_tags_description = "projectResourceTagsDescription",
        .status = "status",
    };
};

pub const CreateProjectProfileOutput = struct {
    /// Specifies whether custom project resource tags are supported.
    allow_custom_project_resource_tags: ?bool = null,

    /// A timestamp at which a project profile is created.
    created_at: ?i64 = null,

    /// A user who created a project profile.
    created_by: []const u8,

    /// A project profile description.
    description: ?[]const u8 = null,

    /// The ID of the domain where a project profile is created.
    domain_id: []const u8,

    /// The ID of the domain unit where a project profile is created.
    domain_unit_id: ?[]const u8 = null,

    /// Environment configurations of a project profile.
    environment_configurations: ?[]const EnvironmentConfiguration = null,

    /// Project profile ID.
    id: []const u8,

    /// A timestamp when a project profile was last updated.
    last_updated_at: ?i64 = null,

    /// Project profile name.
    name: []const u8,

    /// The resource tags of the project profile.
    project_resource_tags: ?[]const ResourceTagParameter = null,

    /// Field viewable through the UI that provides a project user with the allowed
    /// resource tag specifications.
    project_resource_tags_description: ?[]const u8 = null,

    /// Project profile status.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProjectProfileInput, options: CallOptions) !CreateProjectProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProjectProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/project-profiles");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allow_custom_project_resource_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"allowCustomProjectResourceTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.domain_unit_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"domainUnitIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.project_resource_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"projectResourceTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.project_resource_tags_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"projectResourceTagsDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProjectProfileOutput {
    var result: CreateProjectProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateProjectProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
