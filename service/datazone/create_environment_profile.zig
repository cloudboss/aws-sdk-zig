const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentParameter = @import("environment_parameter.zig").EnvironmentParameter;
const CustomParameter = @import("custom_parameter.zig").CustomParameter;

pub const CreateEnvironmentProfileInput = struct {
    /// The Amazon Web Services account in which the Amazon DataZone environment is
    /// created.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services region in which this environment profile is created.
    aws_account_region: ?[]const u8 = null,

    /// The description of this Amazon DataZone environment profile.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which this environment profile is
    /// created.
    domain_identifier: []const u8,

    /// The ID of the blueprint with which this environment profile is created.
    environment_blueprint_identifier: []const u8,

    /// The name of this Amazon DataZone environment profile.
    name: []const u8,

    /// The identifier of the project in which to create the environment profile.
    project_identifier: []const u8,

    /// The user parameters of this Amazon DataZone environment profile.
    user_parameters: ?[]const EnvironmentParameter = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .aws_account_region = "awsAccountRegion",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .environment_blueprint_identifier = "environmentBlueprintIdentifier",
        .name = "name",
        .project_identifier = "projectIdentifier",
        .user_parameters = "userParameters",
    };
};

pub const CreateEnvironmentProfileOutput = struct {
    /// The Amazon Web Services account ID in which this Amazon DataZone environment
    /// profile is created.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services region in which this Amazon DataZone environment
    /// profile is created.
    aws_account_region: ?[]const u8 = null,

    /// The timestamp of when this environment profile was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created this environment profile.
    created_by: []const u8,

    /// The description of this Amazon DataZone environment profile.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which this environment profile is
    /// created.
    domain_id: []const u8,

    /// The ID of the blueprint with which this environment profile is created.
    environment_blueprint_id: []const u8,

    /// The ID of this Amazon DataZone environment profile.
    id: []const u8,

    /// The name of this Amazon DataZone environment profile.
    name: []const u8,

    /// The ID of the Amazon DataZone project in which this environment profile is
    /// created.
    project_id: ?[]const u8 = null,

    /// The timestamp of when this environment profile was updated.
    updated_at: ?i64 = null,

    /// The user parameters of this Amazon DataZone environment profile.
    user_parameters: ?[]const CustomParameter = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .aws_account_region = "awsAccountRegion",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .environment_blueprint_id = "environmentBlueprintId",
        .id = "id",
        .name = "name",
        .project_id = "projectId",
        .updated_at = "updatedAt",
        .user_parameters = "userParameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentProfileInput, options: CallOptions) !CreateEnvironmentProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environment-profiles");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.aws_account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"awsAccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.aws_account_region) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"awsAccountRegion\":");
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
    try body_buf.appendSlice(allocator, "\"environmentBlueprintIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.environment_blueprint_identifier), input.environment_blueprint_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"projectIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.project_identifier), input.project_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentProfileOutput {
    var result: CreateEnvironmentProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateEnvironmentProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
