const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const UpdateOdbPeeringConnectionInput = struct {
    /// A new display name for the peering connection.
    display_name: ?[]const u8 = null,

    /// The identifier of the Oracle Database@Amazon Web Services peering connection
    /// to update.
    odb_peering_connection_id: []const u8,

    /// A list of CIDR blocks to add to the peering connection. These CIDR blocks
    /// define the IP address ranges that can communicate through the peering
    /// connection. The CIDR blocks must not overlap with existing CIDR blocks in
    /// the Oracle Database@Amazon Web Services network.
    peer_network_cidrs_to_be_added: ?[]const []const u8 = null,

    /// A list of CIDR blocks to remove from the peering connection. The CIDR blocks
    /// must currently exist in the peering connection.
    peer_network_cidrs_to_be_removed: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .odb_peering_connection_id = "odbPeeringConnectionId",
        .peer_network_cidrs_to_be_added = "peerNetworkCidrsToBeAdded",
        .peer_network_cidrs_to_be_removed = "peerNetworkCidrsToBeRemoved",
    };
};

pub const UpdateOdbPeeringConnectionOutput = struct {
    /// The display name of the peering connection.
    display_name: ?[]const u8 = null,

    /// The identifier of the Oracle Database@Amazon Web Services peering connection
    /// that was updated.
    odb_peering_connection_id: []const u8,

    /// The status of the peering connection update operation.
    status: ?ResourceStatus = null,

    /// Additional information about the status of the peering connection update
    /// operation.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .odb_peering_connection_id = "odbPeeringConnectionId",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateOdbPeeringConnectionInput, options: CallOptions) !UpdateOdbPeeringConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOdbPeeringConnectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Odb.UpdateOdbPeeringConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateOdbPeeringConnectionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateOdbPeeringConnectionOutput, body, allocator);
}
