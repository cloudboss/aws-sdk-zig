const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BusinessSupportSubscriptionContract = @import("business_support_subscription_contract.zig").BusinessSupportSubscriptionContract;

pub const ListBusinessSupportSubscriptionHistoryInput = struct {
    /// The account ID to filter results to a specific account. If you don't specify
    /// a value, the response includes subscription history for all accounts.
    account_id: ?[]const u8 = null,

    /// The billing month to retrieve subscription contracts for, in YYYY-MM format.
    /// If you don't specify a value, defaults to the current month.
    billing_month: ?[]const u8 = null,

    /// The end date to filter subscription contracts to.
    end_date: ?i64 = null,

    /// The maximum number of results to return per page. Default is 100.
    max_results: ?i32 = null,

    /// The pagination token for the next page of results.
    next_token: ?[]const u8 = null,

    /// The start date to filter subscription contracts from.
    start_date: ?i64 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .billing_month = "billingMonth",
        .end_date = "endDate",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .start_date = "startDate",
    };
};

pub const ListBusinessSupportSubscriptionHistoryOutput = struct {
    /// The pagination token for the next page of results.
    next_token: ?[]const u8 = null,

    /// The list of Business Support subscription contracts.
    subscription_contracts: ?[]const BusinessSupportSubscriptionContract = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .subscription_contracts = "subscriptionContracts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBusinessSupportSubscriptionHistoryInput, options: CallOptions) !ListBusinessSupportSubscriptionHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "billing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBusinessSupportSubscriptionHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billing", "Billing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.ListBusinessSupportSubscriptionHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBusinessSupportSubscriptionHistoryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListBusinessSupportSubscriptionHistoryOutput, body, allocator);
}
