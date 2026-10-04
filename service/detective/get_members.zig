const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberDetail = @import("member_detail.zig").MemberDetail;
const UnprocessedAccount = @import("unprocessed_account.zig").UnprocessedAccount;

pub const GetMembersInput = struct {
    /// The list of Amazon Web Services account identifiers for the member account
    /// for which to
    /// return member details. You can request details for up to 50 member accounts
    /// at a
    /// time.
    ///
    /// You cannot use `GetMembers` to retrieve information about member accounts
    /// that were removed from the behavior graph.
    account_ids: []const []const u8,

    /// The ARN of the behavior graph for which to request the member details.
    graph_arn: []const u8,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .graph_arn = "GraphArn",
    };
};

pub const GetMembersOutput = struct {
    /// The member account details that Detective is returning in response to the
    /// request.
    member_details: ?[]const MemberDetail = null,

    /// The requested member accounts for which Detective was unable to return
    /// member
    /// details.
    ///
    /// For each account, provides the reason why the request could not be
    /// processed.
    unprocessed_accounts: ?[]const UnprocessedAccount = null,

    pub const json_field_names = .{
        .member_details = "MemberDetails",
        .unprocessed_accounts = "UnprocessedAccounts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMembersInput, options: CallOptions) !GetMembersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMembersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.detective", "Detective", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/graph/members/get";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMembersOutput {
    var result: GetMembersOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetMembersOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
