const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataGrantAcceptanceState = @import("data_grant_acceptance_state.zig").DataGrantAcceptanceState;
const GrantDistributionScope = @import("grant_distribution_scope.zig").GrantDistributionScope;

pub const GetReceivedDataGrantInput = struct {
    /// The Amazon Resource Name (ARN) of the data grant.
    data_grant_arn: []const u8,

    pub const json_field_names = .{
        .data_grant_arn = "DataGrantArn",
    };
};

pub const GetReceivedDataGrantOutput = struct {
    /// The acceptance state of the data grant.
    acceptance_state: DataGrantAcceptanceState,

    /// The timestamp of when the data grant was accepted.
    accepted_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the data grant.
    arn: []const u8,

    /// The timestamp of when the data grant was created.
    created_at: i64,

    /// The ID of the data set associated to the data grant.
    data_set_id: []const u8,

    /// The description of the data grant.
    description: ?[]const u8 = null,

    /// The timestamp of when access to the associated data set ends.
    ends_at: ?i64 = null,

    /// The distribution scope for the data grant.
    grant_distribution_scope: GrantDistributionScope,

    /// The ID of the data grant.
    id: []const u8,

    /// The name of the data grant.
    name: []const u8,

    /// The Amazon Web Services account ID of the data grant receiver.
    receiver_principal: []const u8,

    /// The Amazon Web Services account ID of the data grant sender.
    sender_principal: ?[]const u8 = null,

    /// The timestamp of when the data grant was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .acceptance_state = "AcceptanceState",
        .accepted_at = "AcceptedAt",
        .arn = "Arn",
        .created_at = "CreatedAt",
        .data_set_id = "DataSetId",
        .description = "Description",
        .ends_at = "EndsAt",
        .grant_distribution_scope = "GrantDistributionScope",
        .id = "Id",
        .name = "Name",
        .receiver_principal = "ReceiverPrincipal",
        .sender_principal = "SenderPrincipal",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReceivedDataGrantInput, options: CallOptions) !GetReceivedDataGrantOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dataexchange", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReceivedDataGrantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataexchange", "DataExchange", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/received-data-grants/");
    try path_buf.appendSlice(allocator, input.data_grant_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReceivedDataGrantOutput {
    var result: GetReceivedDataGrantOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetReceivedDataGrantOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
