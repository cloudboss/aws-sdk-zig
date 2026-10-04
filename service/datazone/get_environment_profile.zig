const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomParameter = @import("custom_parameter.zig").CustomParameter;

pub const GetEnvironmentProfileInput = struct {
    /// The ID of the Amazon DataZone domain in which this environment profile
    /// exists.
    domain_identifier: []const u8,

    /// The ID of the environment profile.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetEnvironmentProfileOutput = struct {
    /// The ID of the Amazon Web Services account where this environment profile
    /// exists.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services region where this environment profile exists.
    aws_account_region: ?[]const u8 = null,

    /// The timestamp of when this environment profile was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created this environment profile.
    created_by: []const u8,

    /// The description of the environment profile.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which this environment profile
    /// exists.
    domain_id: []const u8,

    /// The ID of the blueprint with which this environment profile is created.
    environment_blueprint_id: []const u8,

    /// The ID of the environment profile.
    id: []const u8,

    /// The name of the environment profile.
    name: []const u8,

    /// The ID of the Amazon DataZone project in which this environment profile is
    /// created.
    project_id: ?[]const u8 = null,

    /// The timestamp of when this environment profile was upated.
    updated_at: ?i64 = null,

    /// The user parameters of the environment profile.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEnvironmentProfileInput, options: CallOptions) !GetEnvironmentProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEnvironmentProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environment-profiles/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEnvironmentProfileOutput {
    const result: GetEnvironmentProfileOutput = try aws.json.parseJsonObject(
        GetEnvironmentProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
