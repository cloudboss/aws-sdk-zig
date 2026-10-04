const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeRequestAction = @import("change_request_action.zig").ChangeRequestAction;
const CollaborationChangeRequest = @import("collaboration_change_request.zig").CollaborationChangeRequest;

pub const UpdateCollaborationChangeRequestInput = struct {
    /// The action to perform on the change request. Valid values include APPROVE
    /// (approve the change), DENY (reject the change), CANCEL (cancel the request),
    /// and COMMIT (commit after the request is approved).
    ///
    /// For change requests without automatic approval, a member in the
    /// collaboration can manually APPROVE or DENY a change request. The
    /// collaboration owner can manually CANCEL or COMMIT a change request.
    action: ChangeRequestAction,

    /// The unique identifier of the specific change request to be updated within
    /// the collaboration.
    change_request_identifier: []const u8,

    /// The unique identifier of the collaboration that contains the change request
    /// to be updated.
    collaboration_identifier: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .change_request_identifier = "changeRequestIdentifier",
        .collaboration_identifier = "collaborationIdentifier",
    };
};

pub const UpdateCollaborationChangeRequestOutput = struct {
    collaboration_change_request: ?CollaborationChangeRequest = null,

    pub const json_field_names = .{
        .collaboration_change_request = "collaborationChangeRequest",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCollaborationChangeRequestInput, options: CallOptions) !UpdateCollaborationChangeRequestOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCollaborationChangeRequestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/collaborations/");
    try path_buf.appendSlice(allocator, input.collaboration_identifier);
    try path_buf.appendSlice(allocator, "/changeRequests/");
    try path_buf.appendSlice(allocator, input.change_request_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCollaborationChangeRequestOutput {
    const result: UpdateCollaborationChangeRequestOutput = try aws.json.parseJsonObject(
        UpdateCollaborationChangeRequestOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
