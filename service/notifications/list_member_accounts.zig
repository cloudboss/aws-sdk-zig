const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberAccountNotificationConfigurationStatus = @import("member_account_notification_configuration_status.zig").MemberAccountNotificationConfigurationStatus;
const MemberAccount = @import("member_account.zig").MemberAccount;

pub const ListMemberAccountsInput = struct {
    /// The maximum number of results to return in a single call. Valid values are
    /// 1-100.
    max_results: ?i32 = null,

    /// The member account identifier used to filter the results.
    member_account: ?[]const u8 = null,

    /// The token for the next page of results. Use the value returned in the
    /// previous response.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the notification configuration used to
    /// filter the member accounts.
    notification_configuration_arn: []const u8,

    /// The organizational unit ID used to filter the member accounts.
    organizational_unit_id: ?[]const u8 = null,

    /// The status used to filter the member accounts.
    status: ?MemberAccountNotificationConfigurationStatus = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .member_account = "memberAccount",
        .next_token = "nextToken",
        .notification_configuration_arn = "notificationConfigurationArn",
        .organizational_unit_id = "organizationalUnitId",
        .status = "status",
    };
};

pub const ListMemberAccountsOutput = struct {
    /// The list of member accounts that match the specified criteria.
    member_accounts: ?[]const MemberAccount = null,

    /// The token to use for the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .member_accounts = "memberAccounts",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMemberAccountsInput, options: CallOptions) !ListMemberAccountsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "notifications", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMemberAccountsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-member-accounts";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.member_account) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "memberAccount=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "notificationConfigurationArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.notification_configuration_arn);
    query_has_prev = true;
    if (input.organizational_unit_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "organizationalUnitId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMemberAccountsOutput {
    const result: ListMemberAccountsOutput = try aws.json.parseJsonObject(
        ListMemberAccountsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
