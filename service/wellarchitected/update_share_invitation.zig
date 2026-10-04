const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ShareInvitationAction = @import("share_invitation_action.zig").ShareInvitationAction;
const ShareInvitation = @import("share_invitation.zig").ShareInvitation;

pub const UpdateShareInvitationInput = struct {
    share_invitation_action: ShareInvitationAction,

    /// The ID assigned to the share invitation.
    share_invitation_id: []const u8,

    pub const json_field_names = .{
        .share_invitation_action = "ShareInvitationAction",
        .share_invitation_id = "ShareInvitationId",
    };
};

pub const UpdateShareInvitationOutput = struct {
    /// The updated workload or custom lens share invitation.
    share_invitation: ?ShareInvitation = null,

    pub const json_field_names = .{
        .share_invitation = "ShareInvitation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateShareInvitationInput, options: CallOptions) !UpdateShareInvitationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateShareInvitationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/shareInvitations/");
    try path_buf.appendSlice(allocator, input.share_invitation_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ShareInvitationAction\":");
    try aws.json.writeValue(@TypeOf(input.share_invitation_action), input.share_invitation_action, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateShareInvitationOutput {
    const result: UpdateShareInvitationOutput = try aws.json.parseJsonObject(
        UpdateShareInvitationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
