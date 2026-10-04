const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentParameter = @import("environment_parameter.zig").EnvironmentParameter;
const CustomParameter = @import("custom_parameter.zig").CustomParameter;

pub const UpdateEnvironmentProfileInput = struct {
    /// The Amazon Web Services account in which a specified environment profile is
    /// to be udpated.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services Region in which a specified environment profile is
    /// to be updated.
    aws_account_region: ?[]const u8 = null,

    /// The description to be updated as part of the `UpdateEnvironmentProfile`
    /// action.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which an environment profile
    /// is to be updated.
    domain_identifier: []const u8,

    /// The identifier of the environment profile that is to be updated.
    identifier: []const u8,

    /// The name to be updated as part of the `UpdateEnvironmentProfile` action.
    name: ?[]const u8 = null,

    /// The user parameters to be updated as part of the `UpdateEnvironmentProfile`
    /// action.
    user_parameters: ?[]const EnvironmentParameter = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .aws_account_region = "awsAccountRegion",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .name = "name",
        .user_parameters = "userParameters",
    };
};

pub const UpdateEnvironmentProfileOutput = struct {
    /// The Amazon Web Services account in which a specified environment profile is
    /// to be udpated.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services Region in which a specified environment profile is
    /// to be updated.
    aws_account_region: ?[]const u8 = null,

    /// The timestamp of when the environment profile was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the environment profile.
    created_by: []const u8,

    /// The description to be updated as part of the `UpdateEnvironmentProfile`
    /// action.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which the environment
    /// profile is to be updated.
    domain_id: []const u8,

    /// The identifier of the blueprint of the environment profile that is to be
    /// updated.
    environment_blueprint_id: []const u8,

    /// The identifier of the environment profile that is to be udpated.
    id: []const u8,

    /// The name to be updated as part of the `UpdateEnvironmentProfile` action.
    name: []const u8,

    /// The identifier of the project of the environment profile that is to be
    /// updated.
    project_id: ?[]const u8 = null,

    /// The timestamp of when the environment profile was updated.
    updated_at: ?i64 = null,

    /// The user parameters to be updated as part of the `UpdateEnvironmentProfile`
    /// action.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEnvironmentProfileInput, options: CallOptions) !UpdateEnvironmentProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEnvironmentProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environment-profiles/");
    try path_buf.appendSlice(allocator, input.identifier);
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
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEnvironmentProfileOutput {
    const result: UpdateEnvironmentProfileOutput = try aws.json.parseJsonObject(
        UpdateEnvironmentProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
