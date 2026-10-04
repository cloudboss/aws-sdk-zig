const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteResourcePolicyInput = struct {
    /// The name of the resource policy to delete.
    policy_name: []const u8,

    /// Specifies a specific policy revision to delete. Provide a `PolicyRevisionId`
    /// to ensure an atomic delete operation. If the provided revision id does
    /// not match the latest policy revision id, an
    /// `InvalidPolicyRevisionIdException` exception is returned.
    policy_revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_name = "PolicyName",
        .policy_revision_id = "PolicyRevisionId",
    };
};

pub const DeleteResourcePolicyOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteResourcePolicyInput, options: CallOptions) !DeleteResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "xray", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteResourcePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DeleteResourcePolicy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PolicyName\":");
    try aws.json.writeValue(@TypeOf(input.policy_name), input.policy_name, allocator, &body_buf);
    has_prev = true;
    if (input.policy_revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PolicyRevisionId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteResourcePolicyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteResourcePolicyOutput = .{};

    return result;
}
