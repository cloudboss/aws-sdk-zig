const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const ConnectionTypeDetail = @import("connection_type_detail.zig").ConnectionTypeDetail;

pub const CancelConnectionInput = struct {
    /// The catalog identifier where the connection exists.
    catalog: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: []const u8,

    /// The type of connection to cancel (e.g., reseller, distributor, technology
    /// partner).
    connection_type: ConnectionType,

    /// The unique identifier of the connection to cancel.
    identifier: []const u8,

    /// The reason for canceling the connection, providing context for the
    /// termination.
    reason: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .connection_type = "ConnectionType",
        .identifier = "Identifier",
        .reason = "Reason",
    };
};

pub const CancelConnectionOutput = struct {
    /// The Amazon Resource Name (ARN) of the canceled connection.
    arn: []const u8,

    /// The catalog identifier where the connection was canceled.
    catalog: []const u8,

    /// The list of connection types that were active before cancellation.
    connection_types: ?[]const aws.map.MapEntry(ConnectionTypeDetail) = null,

    /// The unique identifier of the canceled connection.
    id: []const u8,

    /// The AWS account ID of the other participant in the canceled connection.
    other_participant_account_id: []const u8,

    /// The timestamp when the connection was last updated (canceled).
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .connection_types = "ConnectionTypes",
        .id = "Id",
        .other_participant_account_id = "OtherParticipantAccountId",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelConnectionInput, options: CallOptions) !CancelConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-account", "PartnerCentral Account", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.CancelConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelConnectionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CancelConnectionOutput, body, allocator);
}
