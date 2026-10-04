const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionMode = @import("connection_mode.zig").ConnectionMode;
const ConnectionProperties = @import("connection_properties.zig").ConnectionProperties;
const DomainInformationContainer = @import("domain_information_container.zig").DomainInformationContainer;
const OutboundConnectionStatus = @import("outbound_connection_status.zig").OutboundConnectionStatus;

pub const CreateOutboundConnectionInput = struct {
    /// Name of the connection.
    connection_alias: []const u8,

    /// The connection mode.
    connection_mode: ?ConnectionMode = null,

    /// The `ConnectionProperties` for the outbound connection.
    connection_properties: ?ConnectionProperties = null,

    /// Name and Region of the source (local) domain.
    local_domain_info: DomainInformationContainer,

    /// Name and Region of the destination (remote) domain.
    remote_domain_info: DomainInformationContainer,

    pub const json_field_names = .{
        .connection_alias = "ConnectionAlias",
        .connection_mode = "ConnectionMode",
        .connection_properties = "ConnectionProperties",
        .local_domain_info = "LocalDomainInfo",
        .remote_domain_info = "RemoteDomainInfo",
    };
};

pub const CreateOutboundConnectionOutput = struct {
    /// Name of the connection.
    connection_alias: ?[]const u8 = null,

    /// The unique identifier for the created outbound connection, which is used for
    /// subsequent
    /// operations on the connection.
    connection_id: ?[]const u8 = null,

    /// The connection mode.
    connection_mode: ?ConnectionMode = null,

    /// The `ConnectionProperties` for the newly created connection.
    connection_properties: ?ConnectionProperties = null,

    /// The status of the connection.
    connection_status: ?OutboundConnectionStatus = null,

    /// Information about the source (local) domain.
    local_domain_info: ?DomainInformationContainer = null,

    /// Information about the destination (remote) domain.
    remote_domain_info: ?DomainInformationContainer = null,

    pub const json_field_names = .{
        .connection_alias = "ConnectionAlias",
        .connection_id = "ConnectionId",
        .connection_mode = "ConnectionMode",
        .connection_properties = "ConnectionProperties",
        .connection_status = "ConnectionStatus",
        .local_domain_info = "LocalDomainInfo",
        .remote_domain_info = "RemoteDomainInfo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOutboundConnectionInput, options: CallOptions) !CreateOutboundConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOutboundConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/opensearch/cc/outboundConnection";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConnectionAlias\":");
    try aws.json.writeValue(@TypeOf(input.connection_alias), input.connection_alias, allocator, &body_buf);
    has_prev = true;
    if (input.connection_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConnectionMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connection_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConnectionProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LocalDomainInfo\":");
    try aws.json.writeValue(@TypeOf(input.local_domain_info), input.local_domain_info, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RemoteDomainInfo\":");
    try aws.json.writeValue(@TypeOf(input.remote_domain_info), input.remote_domain_info, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOutboundConnectionOutput {
    var result: CreateOutboundConnectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateOutboundConnectionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
