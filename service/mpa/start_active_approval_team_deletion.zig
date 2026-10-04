const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartActiveApprovalTeamDeletionInput = struct {
    /// Amazon Resource Name (ARN) for the team.
    arn: []const u8,

    /// Number of days between when the team approves the delete request and when
    /// the team is deleted.
    pending_window_days: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .pending_window_days = "PendingWindowDays",
    };
};

pub const StartActiveApprovalTeamDeletionOutput = struct {
    /// Timestamp when the deletion process is scheduled to complete.
    deletion_completion_time: ?i64 = null,

    /// Timestamp when the deletion process was initiated.
    deletion_start_time: ?i64 = null,

    pub const json_field_names = .{
        .deletion_completion_time = "DeletionCompletionTime",
        .deletion_start_time = "DeletionStartTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartActiveApprovalTeamDeletionInput, options: CallOptions) !StartActiveApprovalTeamDeletionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mpa", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartActiveApprovalTeamDeletionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mpa", "MPA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/approval-teams/");
    try path_buf.appendSlice(allocator, input.arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "Delete");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.pending_window_days) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PendingWindowDays\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartActiveApprovalTeamDeletionOutput {
    const result: StartActiveApprovalTeamDeletionOutput = try aws.json.parseJsonObject(
        StartActiveApprovalTeamDeletionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
