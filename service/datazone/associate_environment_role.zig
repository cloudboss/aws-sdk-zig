const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateEnvironmentRoleInput = struct {
    /// The ID of the Amazon DataZone domain in which the environment role is
    /// associated.
    domain_identifier: []const u8,

    /// The ID of the Amazon DataZone environment.
    environment_identifier: []const u8,

    /// The ARN of the environment role.
    environment_role_arn: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .environment_identifier = "environmentIdentifier",
        .environment_role_arn = "environmentRoleArn",
    };
};

pub const AssociateEnvironmentRoleOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateEnvironmentRoleInput, options: CallOptions) !AssociateEnvironmentRoleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateEnvironmentRoleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_identifier);
    try path_buf.appendSlice(allocator, "/roles/");
    try path_buf.appendSlice(allocator, input.environment_role_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateEnvironmentRoleOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AssociateEnvironmentRoleOutput = .{};

    return result;
}
