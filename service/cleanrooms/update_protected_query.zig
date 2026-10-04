const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TargetProtectedQueryStatus = @import("target_protected_query_status.zig").TargetProtectedQueryStatus;
const ProtectedQuery = @import("protected_query.zig").ProtectedQuery;

pub const UpdateProtectedQueryInput = struct {
    /// The identifier for a member of a protected query instance.
    membership_identifier: []const u8,

    /// The identifier for a protected query instance.
    protected_query_identifier: []const u8,

    /// The target status of a query. Used to update the execution status of a
    /// currently running query.
    target_status: TargetProtectedQueryStatus,

    pub const json_field_names = .{
        .membership_identifier = "membershipIdentifier",
        .protected_query_identifier = "protectedQueryIdentifier",
        .target_status = "targetStatus",
    };
};

pub const UpdateProtectedQueryOutput = struct {
    /// The protected query output.
    protected_query: ?ProtectedQuery = null,

    pub const json_field_names = .{
        .protected_query = "protectedQuery",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProtectedQueryInput, options: CallOptions) !UpdateProtectedQueryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProtectedQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/protectedQueries/");
    try path_buf.appendSlice(allocator, input.protected_query_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetStatus\":");
    try aws.json.writeValue(@TypeOf(input.target_status), input.target_status, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProtectedQueryOutput {
    const result: UpdateProtectedQueryOutput = try aws.json.parseJsonObject(
        UpdateProtectedQueryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
