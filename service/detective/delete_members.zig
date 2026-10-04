const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UnprocessedAccount = @import("unprocessed_account.zig").UnprocessedAccount;

pub const DeleteMembersInput = struct {
    /// The list of Amazon Web Services account identifiers for the member accounts
    /// to remove
    /// from the behavior graph. You can remove up to 50 member accounts at a time.
    account_ids: []const []const u8,

    /// The ARN of the behavior graph to remove members from.
    graph_arn: []const u8,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .graph_arn = "GraphArn",
    };
};

pub const DeleteMembersOutput = struct {
    /// The list of Amazon Web Services account identifiers for the member accounts
    /// that Detective successfully removed from the behavior graph.
    account_ids: ?[]const []const u8 = null,

    /// The list of member accounts that Detective was not able to remove from the
    /// behavior graph. For each member account, provides the reason that the
    /// deletion could not be
    /// processed.
    unprocessed_accounts: ?[]const UnprocessedAccount = null,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .unprocessed_accounts = "UnprocessedAccounts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteMembersInput, options: CallOptions) !DeleteMembersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "detective", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteMembersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.detective", "Detective", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/graph/members/removal";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AccountIds\":");
    try aws.json.writeValue(@TypeOf(input.account_ids), input.account_ids, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GraphArn\":");
    try aws.json.writeValue(@TypeOf(input.graph_arn), input.graph_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteMembersOutput {
    var result: DeleteMembersOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteMembersOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
