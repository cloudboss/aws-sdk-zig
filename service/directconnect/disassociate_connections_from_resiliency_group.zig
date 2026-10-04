const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResiliencyGroupAssociation = @import("resiliency_group_association.zig").ResiliencyGroupAssociation;

pub const DisassociateConnectionsFromResiliencyGroupInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request.
    client_token: ?[]const u8 = null,

    /// The IDs or ARNs of the connections to disassociate from the resiliency
    /// group.
    connection_identifiers: []const []const u8,

    /// The ID of the resiliency group.
    resiliency_group_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .connection_identifiers = "connectionIdentifiers",
        .resiliency_group_id = "resiliencyGroupId",
    };
};

pub const DisassociateConnectionsFromResiliencyGroupOutput = struct {
    /// The connection associations for the resiliency group.
    resiliency_group_associations: ?[]const ResiliencyGroupAssociation = null,

    pub const json_field_names = .{
        .resiliency_group_associations = "resiliencyGroupAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateConnectionsFromResiliencyGroupInput, options: CallOptions) !DisassociateConnectionsFromResiliencyGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "directconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateConnectionsFromResiliencyGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("directconnect", "Direct Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "OvertureService.DisassociateConnectionsFromResiliencyGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateConnectionsFromResiliencyGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisassociateConnectionsFromResiliencyGroupOutput, body, allocator);
}
