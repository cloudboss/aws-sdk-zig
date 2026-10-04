const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const ParticipantType = @import("participant_type.zig").ParticipantType;
const InvitationStatus = @import("invitation_status.zig").InvitationStatus;

pub const CreateConnectionInvitationInput = struct {
    /// The catalog identifier where the connection invitation will be created.
    catalog: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: []const u8,

    /// The type of connection being requested (e.g., reseller, distributor,
    /// technology partner).
    connection_type: ConnectionType,

    /// The email address of the person to send the connection invitation to.
    email: []const u8,

    /// A custom message to include with the connection invitation.
    message: []const u8,

    /// The name of the person sending the connection invitation.
    name: []const u8,

    /// The identifier of the organization or partner to invite for connection.
    receiver_identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .connection_type = "ConnectionType",
        .email = "Email",
        .message = "Message",
        .name = "Name",
        .receiver_identifier = "ReceiverIdentifier",
    };
};

pub const CreateConnectionInvitationOutput = struct {
    /// The Amazon Resource Name (ARN) of the created connection invitation.
    arn: []const u8,

    /// The catalog identifier where the connection invitation was created.
    catalog: []const u8,

    /// The identifier of the connection associated with this invitation.
    connection_id: ?[]const u8 = null,

    /// The type of connection being requested in the invitation.
    connection_type: ConnectionType,

    /// The timestamp when the connection invitation was created.
    created_at: i64,

    /// The timestamp when the connection invitation will expire if not responded
    /// to.
    expires_at: ?i64 = null,

    /// The unique identifier of the created connection invitation.
    id: []const u8,

    /// The custom message included with the connection invitation.
    invitation_message: []const u8,

    /// The email address of the person who sent the connection invitation.
    inviter_email: []const u8,

    /// The name of the person who sent the connection invitation.
    inviter_name: []const u8,

    /// The identifier of the organization or partner being invited.
    other_participant_identifier: []const u8,

    /// The type of participant (inviter or invitee) in the connection invitation.
    participant_type: ParticipantType,

    /// The current status of the connection invitation (pending, accepted,
    /// rejected, etc.).
    status: InvitationStatus,

    /// The timestamp when the connection invitation was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .connection_id = "ConnectionId",
        .connection_type = "ConnectionType",
        .created_at = "CreatedAt",
        .expires_at = "ExpiresAt",
        .id = "Id",
        .invitation_message = "InvitationMessage",
        .inviter_email = "InviterEmail",
        .inviter_name = "InviterName",
        .other_participant_identifier = "OtherParticipantIdentifier",
        .participant_type = "ParticipantType",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectionInvitationInput, options: CallOptions) !CreateConnectionInvitationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectionInvitationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.CreateConnectionInvitation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectionInvitationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateConnectionInvitationOutput, body, allocator);
}
