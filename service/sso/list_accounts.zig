const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountInfo = @import("account_info.zig").AccountInfo;

pub const ListAccountsInput = struct {
    /// The token issued by the `CreateToken` API call. For more information, see
    /// [CreateToken](https://docs.aws.amazon.com/singlesignon/latest/OIDCAPIReference/API_CreateToken.html) in the *IAM Identity Center OIDC API Reference Guide*.
    access_token: []const u8,

    /// This is the number of items clients can request per page.
    max_results: ?i32 = null,

    /// (Optional) When requesting subsequent pages, this is the page token from the
    /// previous
    /// response output.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAccountsOutput = struct {
    /// A paginated response with the list of account information and the next token
    /// if more
    /// results are available.
    account_list: ?[]const AccountInfo = null,

    /// The page token client that is used to retrieve the list of accounts.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_list = "accountList",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAccountsInput, options: CallOptions) !ListAccountsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsssoportal", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAccountsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("portal.sso", "SSO", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/assignment/accounts";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max_result=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next_token=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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
    try request.headers.put(allocator, "x-amz-sso_bearer_token", input.access_token);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAccountsOutput {
    var result: ListAccountsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAccountsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
