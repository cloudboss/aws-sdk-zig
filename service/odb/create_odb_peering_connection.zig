const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateOdbPeeringConnectionInput = struct {
    /// The client token for the ODB peering connection request.
    ///
    /// Constraints:
    ///
    /// * Must be unique for each request.
    client_token: ?[]const u8 = null,

    /// The display name for the ODB peering connection.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the ODB network that initiates the peering
    /// connection.
    odb_network_id: []const u8,

    /// A list of CIDR blocks to add to the peering connection. These CIDR blocks
    /// define the IP address ranges that can communicate through the peering
    /// connection.
    peer_network_cidrs_to_be_added: ?[]const []const u8 = null,

    /// The unique identifier of the peer network. This can be either a VPC ID or
    /// another ODB network ID.
    peer_network_id: []const u8,

    /// The unique identifier of the VPC route table for which a route to the ODB
    /// network is automatically created during peering connection establishment.
    peer_network_route_table_ids: ?[]const []const u8 = null,

    /// The tags to assign to the ODB peering connection.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .display_name = "displayName",
        .odb_network_id = "odbNetworkId",
        .peer_network_cidrs_to_be_added = "peerNetworkCidrsToBeAdded",
        .peer_network_id = "peerNetworkId",
        .peer_network_route_table_ids = "peerNetworkRouteTableIds",
        .tags = "tags",
    };
};

pub const CreateOdbPeeringConnectionOutput = struct {
    /// The display name of the ODB peering connection.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the ODB peering connection.
    odb_peering_connection_id: []const u8,

    /// The status of the ODB peering connection.
    status: ?ResourceStatus = null,

    /// The reason for the current status of the ODB peering connection.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .odb_peering_connection_id = "odbPeeringConnectionId",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOdbPeeringConnectionInput, options: CallOptions) !CreateOdbPeeringConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "odb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOdbPeeringConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.CreateOdbPeeringConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOdbPeeringConnectionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateOdbPeeringConnectionOutput, body, allocator);
}
