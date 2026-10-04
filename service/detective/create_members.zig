const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Account = @import("account.zig").Account;
const MemberDetail = @import("member_detail.zig").MemberDetail;
const UnprocessedAccount = @import("unprocessed_account.zig").UnprocessedAccount;

pub const CreateMembersInput = struct {
    /// The list of Amazon Web Services accounts to invite or to enable. You can
    /// invite or enable
    /// up to 50 accounts at a time. For each invited account, the account list
    /// contains the
    /// account identifier and the Amazon Web Services account root user email
    /// address. For
    /// organization accounts in the organization behavior graph, the email address
    /// is not
    /// required.
    accounts: []const Account,

    /// if set to `true`, then the invited accounts do not receive email
    /// notifications. By default, this is set to `false`, and the invited accounts
    /// receive email notifications.
    ///
    /// Organization accounts in the organization behavior graph do not receive
    /// email
    /// notifications.
    disable_email_notification: ?bool = null,

    /// The ARN of the behavior graph.
    graph_arn: []const u8,

    /// Customized message text to include in the invitation email message to the
    /// invited member
    /// accounts.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .accounts = "Accounts",
        .disable_email_notification = "DisableEmailNotification",
        .graph_arn = "GraphArn",
        .message = "Message",
    };
};

pub const CreateMembersOutput = struct {
    /// The set of member account invitation or enablement requests that Detective
    /// was
    /// able to process. This includes accounts that are being verified, that failed
    /// verification,
    /// and that passed verification and are being sent an invitation or are being
    /// enabled.
    members: ?[]const MemberDetail = null,

    /// The list of accounts for which Detective was unable to process the
    /// invitation
    /// or enablement request. For each account, the list provides the reason why
    /// the request could
    /// not be processed. The list includes accounts that are already member
    /// accounts in the
    /// behavior graph.
    unprocessed_accounts: ?[]const UnprocessedAccount = null,

    pub const json_field_names = .{
        .members = "Members",
        .unprocessed_accounts = "UnprocessedAccounts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMembersInput, options: CallOptions) !CreateMembersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMembersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.detective", "Detective", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/graph/members";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Accounts\":");
    try aws.json.writeValue(@TypeOf(input.accounts), input.accounts, allocator, &body_buf);
    has_prev = true;
    if (input.disable_email_notification) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DisableEmailNotification\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GraphArn\":");
    try aws.json.writeValue(@TypeOf(input.graph_arn), input.graph_arn, allocator, &body_buf);
    has_prev = true;
    if (input.message) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Message\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMembersOutput {
    const result: CreateMembersOutput = try aws.json.parseJsonObject(
        CreateMembersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
