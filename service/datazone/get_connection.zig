const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Configuration = @import("configuration.zig").Configuration;
const ConnectionCredentials = @import("connection_credentials.zig").ConnectionCredentials;
const PhysicalEndpoint = @import("physical_endpoint.zig").PhysicalEndpoint;
const ConnectionPropertiesOutput = @import("connection_properties_output.zig").ConnectionPropertiesOutput;
const ConnectionScope = @import("connection_scope.zig").ConnectionScope;
const ConnectionType = @import("connection_type.zig").ConnectionType;

pub const GetConnectionInput = struct {
    /// The ID of the domain where we get the connection.
    domain_identifier: []const u8,

    /// The connection ID.
    identifier: []const u8,

    /// Specifies whether a connection has a secret.
    with_secret: ?bool = null,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .with_secret = "withSecret",
    };
};

pub const GetConnectionOutput = struct {
    /// The configurations of the connection.
    configurations: ?[]const Configuration = null,

    /// Connection credentials.
    connection_credentials: ?ConnectionCredentials = null,

    /// The ID of the connection.
    connection_id: []const u8,

    /// Connection description.
    description: ?[]const u8 = null,

    /// The domain ID of the connection.
    domain_id: []const u8,

    /// The domain unit ID of the connection.
    domain_unit_id: []const u8,

    /// The ID of the environment.
    environment_id: ?[]const u8 = null,

    /// The environment user role.
    environment_user_role: ?[]const u8 = null,

    /// The name of the connection.
    name: []const u8,

    /// The physical endpoints of the connection.
    physical_endpoints: ?[]const PhysicalEndpoint = null,

    /// The ID of the project.
    project_id: ?[]const u8 = null,

    /// Connection props.
    props: ?ConnectionPropertiesOutput = null,

    /// The scope of the connection.
    scope: ?ConnectionScope = null,

    /// The type of the connection.
    @"type": ConnectionType,

    pub const json_field_names = .{
        .configurations = "configurations",
        .connection_credentials = "connectionCredentials",
        .connection_id = "connectionId",
        .description = "description",
        .domain_id = "domainId",
        .domain_unit_id = "domainUnitId",
        .environment_id = "environmentId",
        .environment_user_role = "environmentUserRole",
        .name = "name",
        .physical_endpoints = "physicalEndpoints",
        .project_id = "projectId",
        .props = "props",
        .scope = "scope",
        .@"type" = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConnectionInput, options: CallOptions) !GetConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/connections/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.with_secret) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "withSecret=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConnectionOutput {
    const result: GetConnectionOutput = try aws.json.parseJsonObject(
        GetConnectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
