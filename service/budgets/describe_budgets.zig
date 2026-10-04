const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Budget = @import("budget.zig").Budget;

pub const DescribeBudgetsInput = struct {
    /// The `accountId` that is associated with the budgets that you want to
    /// describe.
    account_id: []const u8,

    /// An integer that represents how many budgets a paginated response contains.
    /// The default is
    /// 100.
    max_results: ?i32 = null,

    /// The pagination token that you include in your request to indicate the next
    /// set of results that you want to retrieve.
    next_token: ?[]const u8 = null,

    /// Specifies whether the response includes the filter expression associated
    /// with the
    /// budgets. By showing the filter expression, you can see detailed filtering
    /// logic applied to
    /// the budgets, such as Amazon Web Services services or tags that are being
    /// tracked.
    show_filter_expression: ?bool = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .show_filter_expression = "ShowFilterExpression",
    };
};

pub const DescribeBudgetsOutput = struct {
    /// A list of budgets.
    budgets: ?[]const Budget = null,

    /// The pagination token in the service response that indicates the next set of
    /// results that you can retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .budgets = "Budgets",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBudgetsInput, options: CallOptions) !DescribeBudgetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBudgetsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBudgetServiceGateway.DescribeBudgets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBudgetsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeBudgetsOutput, body, allocator);
}
