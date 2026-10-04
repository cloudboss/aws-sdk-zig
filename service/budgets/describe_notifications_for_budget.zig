const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Notification = @import("notification.zig").Notification;

pub const DescribeNotificationsForBudgetInput = struct {
    /// The `accountId` that is associated with the budget whose notifications you
    /// want
    /// descriptions of.
    account_id: []const u8,

    /// The name of the budget whose notifications you want descriptions of.
    budget_name: []const u8,

    /// An optional integer that represents how many entries a paginated response
    /// contains.
    max_results: ?i32 = null,

    /// The pagination token that you include in your request to indicate the next
    /// set of results that you want to retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .budget_name = "BudgetName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeNotificationsForBudgetOutput = struct {
    /// The pagination token in the service response that indicates the next set of
    /// results that you can retrieve.
    next_token: ?[]const u8 = null,

    /// A list of notifications that are associated with a budget.
    notifications: ?[]const Notification = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .notifications = "Notifications",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeNotificationsForBudgetInput, options: CallOptions) !DescribeNotificationsForBudgetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeNotificationsForBudgetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBudgetServiceGateway.DescribeNotificationsForBudget");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeNotificationsForBudgetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeNotificationsForBudgetOutput, body, allocator);
}
