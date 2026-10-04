const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UnprocessedAccount = @import("unprocessed_account.zig").UnprocessedAccount;

pub const CreateInvitationsInput = struct {
    /// An array that lists Amazon Web Services account IDs, one for each account to
    /// send the invitation to.
    account_ids: []const []const u8,

    /// Specifies whether to send the invitation as an email message. If this value
    /// is false, Amazon Macie sends the invitation (as an email message) to the
    /// email address that you specified for the recipient's account when you
    /// associated the account with your account. The default value is false.
    disable_email_notification: ?bool = null,

    /// Custom text to include in the email message that contains the invitation.
    /// The text can contain as many as 80 alphanumeric characters.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .disable_email_notification = "disableEmailNotification",
        .message = "message",
    };
};

pub const CreateInvitationsOutput = struct {
    /// An array of objects, one for each account whose invitation hasn't been
    /// processed. Each object identifies the account and explains why the
    /// invitation hasn't been processed for the account.
    unprocessed_accounts: ?[]const UnprocessedAccount = null,

    pub const json_field_names = .{
        .unprocessed_accounts = "unprocessedAccounts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInvitationsInput, options: CallOptions) !CreateInvitationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInvitationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/invitations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accountIds\":");
    try aws.json.writeValue(@TypeOf(input.account_ids), input.account_ids, allocator, &body_buf);
    has_prev = true;
    if (input.disable_email_notification) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"disableEmailNotification\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.message) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"message\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInvitationsOutput {
    const result: CreateInvitationsOutput = try aws.json.parseJsonObject(
        CreateInvitationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
