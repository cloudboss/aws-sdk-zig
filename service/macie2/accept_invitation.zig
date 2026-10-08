const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AcceptInvitationInput = struct {
    /// The Amazon Web Services account ID for the account that sent the invitation.
    administrator_account_id: ?[]const u8 = null,

    /// The unique identifier for the invitation to accept.
    invitation_id: []const u8,

    /// (Deprecated) The Amazon Web Services account ID for the account that sent
    /// the invitation. This property has been replaced by the
    /// administratorAccountId property and is retained only for backward
    /// compatibility.
    master_account: ?[]const u8 = null,

    pub const json_field_names = .{
        .administrator_account_id = "administratorAccountId",
        .invitation_id = "invitationId",
        .master_account = "masterAccount",
    };
};

pub const AcceptInvitationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcceptInvitationInput, options: CallOptions) !AcceptInvitationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AcceptInvitationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/invitations/accept";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.administrator_account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"administratorAccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"invitationId\":");
    try aws.json.writeValue(@TypeOf(input.invitation_id), input.invitation_id, allocator, &body_buf);
    has_prev = true;
    if (input.master_account) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"masterAccount\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcceptInvitationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AcceptInvitationOutput = .{};

    return result;
}
