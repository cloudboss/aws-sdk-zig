const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeInput = @import("change_input.zig").ChangeInput;
const CollaborationChangeRequest = @import("collaboration_change_request.zig").CollaborationChangeRequest;

pub const CreateCollaborationChangeRequestInput = struct {
    /// The list of changes to apply to the collaboration. Each change specifies the
    /// type of modification and the details of what should be changed.
    changes: []const ChangeInput,

    /// The identifier of the collaboration that the change request is made against.
    collaboration_identifier: []const u8,

    pub const json_field_names = .{
        .changes = "changes",
        .collaboration_identifier = "collaborationIdentifier",
    };
};

pub const CreateCollaborationChangeRequestOutput = struct {
    collaboration_change_request: ?CollaborationChangeRequest = null,

    pub const json_field_names = .{
        .collaboration_change_request = "collaborationChangeRequest",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCollaborationChangeRequestInput, options: CallOptions) !CreateCollaborationChangeRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCollaborationChangeRequestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/collaborations/");
    try path_buf.appendSlice(allocator, input.collaboration_identifier);
    try path_buf.appendSlice(allocator, "/changeRequests");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"changes\":");
    try aws.json.writeValue(@TypeOf(input.changes), input.changes, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCollaborationChangeRequestOutput {
    var result: CreateCollaborationChangeRequestOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCollaborationChangeRequestOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
