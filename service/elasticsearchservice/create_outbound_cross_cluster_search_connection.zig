const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainInformation = @import("domain_information.zig").DomainInformation;
const OutboundCrossClusterSearchConnectionStatus = @import("outbound_cross_cluster_search_connection_status.zig").OutboundCrossClusterSearchConnectionStatus;

pub const CreateOutboundCrossClusterSearchConnectionInput = struct {
    /// Specifies the connection alias that will be used by the customer for this
    /// connection.
    connection_alias: []const u8,

    /// Specifies the `DomainInformation` for the destination Elasticsearch domain.
    destination_domain_info: DomainInformation,

    /// Specifies the `DomainInformation` for the source Elasticsearch domain.
    source_domain_info: DomainInformation,

    pub const json_field_names = .{
        .connection_alias = "ConnectionAlias",
        .destination_domain_info = "DestinationDomainInfo",
        .source_domain_info = "SourceDomainInfo",
    };
};

pub const CreateOutboundCrossClusterSearchConnectionOutput = struct {
    /// Specifies the connection alias provided during the create connection
    /// request.
    connection_alias: ?[]const u8 = null,

    /// Specifies the `OutboundCrossClusterSearchConnectionStatus` for the newly
    /// created connection.
    connection_status: ?OutboundCrossClusterSearchConnectionStatus = null,

    /// Unique id for the created outbound connection, which is used for subsequent
    /// operations on connection.
    cross_cluster_search_connection_id: ?[]const u8 = null,

    /// Specifies the `DomainInformation` for the destination Elasticsearch domain.
    destination_domain_info: ?DomainInformation = null,

    /// Specifies the `DomainInformation` for the source Elasticsearch domain.
    source_domain_info: ?DomainInformation = null,

    pub const json_field_names = .{
        .connection_alias = "ConnectionAlias",
        .connection_status = "ConnectionStatus",
        .cross_cluster_search_connection_id = "CrossClusterSearchConnectionId",
        .destination_domain_info = "DestinationDomainInfo",
        .source_domain_info = "SourceDomainInfo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOutboundCrossClusterSearchConnectionInput, options: CallOptions) !CreateOutboundCrossClusterSearchConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOutboundCrossClusterSearchConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-01-01/es/ccs/outboundConnection";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConnectionAlias\":");
    try aws.json.writeValue(@TypeOf(input.connection_alias), input.connection_alias, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationDomainInfo\":");
    try aws.json.writeValue(@TypeOf(input.destination_domain_info), input.destination_domain_info, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SourceDomainInfo\":");
    try aws.json.writeValue(@TypeOf(input.source_domain_info), input.source_domain_info, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOutboundCrossClusterSearchConnectionOutput {
    const result: CreateOutboundCrossClusterSearchConnectionOutput = try aws.json.parseJsonObject(
        CreateOutboundCrossClusterSearchConnectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
