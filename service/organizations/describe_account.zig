const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Account = @import("account.zig").Account;

pub const DescribeAccountInput = struct {
    /// The unique identifier (ID) of the Amazon Web Services account that you want
    /// information about. You
    /// can get the ID from the ListAccounts or ListAccountsForParent operations.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for an account ID
    /// string requires exactly 12
    /// digits.
    account_id: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
    };
};

pub const DescribeAccountOutput = struct {
    /// A structure that contains information about the requested account.
    ///
    /// The `Status` parameter in the API response will be retired on September 9,
    /// 2026.
    /// Although both the account `State` and account `Status` parameters are
    /// currently
    /// available in the Organizations APIs (`DescribeAccount`, `ListAccounts`,
    /// `ListAccountsForParent`), we recommend that you update your scripts or other
    /// code to
    /// use the `State` parameter instead of `Status` before September 9, 2026.
    account: ?Account = null,

    pub const json_field_names = .{
        .account = "Account",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAccountInput, options: CallOptions) !DescribeAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAccountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.DescribeAccount");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAccountOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAccountOutput, body, allocator);
}
