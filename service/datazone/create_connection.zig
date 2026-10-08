const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AwsLocation = @import("aws_location.zig").AwsLocation;
const Configuration = @import("configuration.zig").Configuration;
const ConnectionPropertiesInput = @import("connection_properties_input.zig").ConnectionPropertiesInput;
const ConnectionScope = @import("connection_scope.zig").ConnectionScope;
const PhysicalEndpoint = @import("physical_endpoint.zig").PhysicalEndpoint;
const ConnectionPropertiesOutput = @import("connection_properties_output.zig").ConnectionPropertiesOutput;
const ConnectionType = @import("connection_type.zig").ConnectionType;

pub const CreateConnectionInput = struct {
    /// The location where the connection is created.
    aws_location: ?AwsLocation = null,

    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The configurations of the connection.
    configurations: ?[]const Configuration = null,

    /// A connection description.
    description: ?[]const u8 = null,

    /// The ID of the domain where the connection is created.
    domain_identifier: []const u8,

    /// Specifies whether the trusted identity propagation is enabled.
    enable_trusted_identity_propagation: ?bool = null,

    /// The ID of the environment where the connection is created.
    environment_identifier: ?[]const u8 = null,

    /// The connection name.
    name: []const u8,

    /// The connection props.
    props: ?ConnectionPropertiesInput = null,

    /// The scope of the connection.
    scope: ?ConnectionScope = null,

    pub const json_field_names = .{
        .aws_location = "awsLocation",
        .client_token = "clientToken",
        .configurations = "configurations",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .enable_trusted_identity_propagation = "enableTrustedIdentityPropagation",
        .environment_identifier = "environmentIdentifier",
        .name = "name",
        .props = "props",
        .scope = "scope",
    };
};

pub const CreateConnectionOutput = struct {
    /// The configurations of the connection.
    configurations: ?[]const Configuration = null,

    /// The ID of the connection.
    connection_id: []const u8,

    /// The connection description.
    description: ?[]const u8 = null,

    /// The ID of the domain where the connection is created.
    domain_id: []const u8,

    /// The ID of the domain unit where the connection is created.
    domain_unit_id: []const u8,

    /// The ID of the environment where the connection is created.
    environment_id: ?[]const u8 = null,

    /// The connection name.
    name: []const u8,

    /// The physical endpoints of the connection.
    physical_endpoints: ?[]const PhysicalEndpoint = null,

    /// The ID of the project where the connection is created.
    project_id: ?[]const u8 = null,

    /// The connection props.
    props: ?ConnectionPropertiesOutput = null,

    /// The scope of the connection.
    scope: ?ConnectionScope = null,

    /// The connection type.
    type: ConnectionType,

    pub const json_field_names = .{
        .configurations = "configurations",
        .connection_id = "connectionId",
        .description = "description",
        .domain_id = "domainId",
        .domain_unit_id = "domainUnitId",
        .environment_id = "environmentId",
        .name = "name",
        .physical_endpoints = "physicalEndpoints",
        .project_id = "projectId",
        .props = "props",
        .scope = "scope",
        .type = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectionInput, options: CallOptions) !CreateConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/connections");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.aws_location) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"awsLocation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enable_trusted_identity_propagation) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enableTrustedIdentityPropagation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.props) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"props\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scope) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scope\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectionOutput {
    const result: CreateConnectionOutput = try aws.json.parseJsonObject(
        CreateConnectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
