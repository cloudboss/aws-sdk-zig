const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BudgetNotificationsForAccount = @import("budget_notifications_for_account.zig").BudgetNotificationsForAccount;

pub const DescribeBudgetNotificationsForAccountInput = struct {
    account_id: []const u8,

    /// An integer that represents how many budgets a paginated response contains.
    /// The
    /// default is 50.
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeBudgetNotificationsForAccountOutput = struct {
    /// A list of budget names and associated notifications for an account.
    budget_notifications_for_account: ?[]const BudgetNotificationsForAccount = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .budget_notifications_for_account = "BudgetNotificationsForAccount",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBudgetNotificationsForAccountInput, options: CallOptions) !DescribeBudgetNotificationsForAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "budgets", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBudgetNotificationsForAccountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("budgets", "Budgets", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBudgetServiceGateway.DescribeBudgetNotificationsForAccount");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBudgetNotificationsForAccountOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeBudgetNotificationsForAccountOutput, body, allocator);
}
