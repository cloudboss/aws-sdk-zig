const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Budget = @import("budget.zig").Budget;

pub const DescribeBudgetInput = struct {
    /// The `accountId` that is associated with the budget that you want a
    /// description of.
    account_id: []const u8,

    /// The name of the budget that you want a description of.
    budget_name: []const u8,

    /// Specifies whether the response includes the filter expression associated
    /// with the
    /// budget. By showing the filter expression, you can see detailed filtering
    /// logic applied to
    /// the budget, such as Amazon Web Services services or tags that are being
    /// tracked.
    show_filter_expression: ?bool = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .budget_name = "BudgetName",
        .show_filter_expression = "ShowFilterExpression",
    };
};

pub const DescribeBudgetOutput = struct {
    /// The description of the budget.
    budget: ?Budget = null,

    pub const json_field_names = .{
        .budget = "Budget",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBudgetInput, options: CallOptions) !DescribeBudgetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBudgetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBudgetServiceGateway.DescribeBudget");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBudgetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeBudgetOutput, body, allocator);
}
