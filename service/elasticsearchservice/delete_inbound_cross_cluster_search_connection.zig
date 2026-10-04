const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InboundCrossClusterSearchConnection = @import("inbound_cross_cluster_search_connection.zig").InboundCrossClusterSearchConnection;

pub const DeleteInboundCrossClusterSearchConnectionInput = struct {
    /// The id of the inbound connection that you want to permanently delete.
    cross_cluster_search_connection_id: []const u8,

    pub const json_field_names = .{
        .cross_cluster_search_connection_id = "CrossClusterSearchConnectionId",
    };
};

pub const DeleteInboundCrossClusterSearchConnectionOutput = struct {
    /// Specifies the `InboundCrossClusterSearchConnection` of deleted inbound
    /// connection.
    cross_cluster_search_connection: ?InboundCrossClusterSearchConnection = null,

    pub const json_field_names = .{
        .cross_cluster_search_connection = "CrossClusterSearchConnection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteInboundCrossClusterSearchConnectionInput, options: CallOptions) !DeleteInboundCrossClusterSearchConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteInboundCrossClusterSearchConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-01-01/es/ccs/inboundConnection/");
    try path_buf.appendSlice(allocator, input.cross_cluster_search_connection_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteInboundCrossClusterSearchConnectionOutput {
    const result: DeleteInboundCrossClusterSearchConnectionOutput = try aws.json.parseJsonObject(
        DeleteInboundCrossClusterSearchConnectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
