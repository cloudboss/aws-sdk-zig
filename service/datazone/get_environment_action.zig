const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionParameters = @import("action_parameters.zig").ActionParameters;

pub const GetEnvironmentActionInput = struct {
    /// The ID of the Amazon DataZone domain in which the `GetEnvironmentAction` API
    /// is invoked.
    domain_identifier: []const u8,

    /// The environment ID of the environment action.
    environment_identifier: []const u8,

    /// The ID of the environment action
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .environment_identifier = "environmentIdentifier",
        .identifier = "identifier",
    };
};

pub const GetEnvironmentActionOutput = struct {
    /// The description of the environment action.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the environment action lives.
    domain_id: []const u8,

    /// The environment ID of the environment action.
    environment_id: []const u8,

    /// The ID of the environment action.
    id: []const u8,

    /// The name of the environment action.
    name: []const u8,

    /// The parameters of the environment action.
    parameters: ?ActionParameters = null,

    pub const json_field_names = .{
        .description = "description",
        .domain_id = "domainId",
        .environment_id = "environmentId",
        .id = "id",
        .name = "name",
        .parameters = "parameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEnvironmentActionInput, options: CallOptions) !GetEnvironmentActionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEnvironmentActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_identifier);
    try path_buf.appendSlice(allocator, "/actions/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEnvironmentActionOutput {
    const result: GetEnvironmentActionOutput = try aws.json.parseJsonObject(
        GetEnvironmentActionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
