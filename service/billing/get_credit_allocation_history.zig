const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreditAllocationHistoryEntry = @import("credit_allocation_history_entry.zig").CreditAllocationHistoryEntry;

pub const GetCreditAllocationHistoryInput = struct {
    /// The Amazon Web Services account ID whose allocation history to retrieve.
    /// Must be a 12-digit numeric string.
    account_id: []const u8,

    /// Filters the result to a single credit. When omitted, returns allocation
    /// entries for all credits.
    credit_id: ?i64 = null,

    /// Inclusive end date as Unix epoch seconds.
    end_date: i64,

    /// The maximum number of records to return per page. Range: 1 to 1000. Default:
    /// 100.
    max_results: ?i32 = null,

    /// Pagination token from a previous response. Pass the value returned in
    /// `nextToken` to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// Inclusive start date as Unix epoch seconds. Must be on or before `endDate`.
    /// The range from `startDate` to `endDate` cannot exceed 24 billing months.
    start_date: i64,

    pub const json_field_names = .{
        .account_id = "accountId",
        .credit_id = "creditId",
        .end_date = "endDate",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .start_date = "startDate",
    };
};

pub const GetCreditAllocationHistoryOutput = struct {
    /// Allocation entries sorted by `billingMonth` in descending order.
    credit_allocation_history_list: ?[]const CreditAllocationHistoryEntry = null,

    /// Billing months in `YYYY-MM` format that failed to return data. Non-empty
    /// only when `partialResults` is `true`.
    failed_months: ?[]const []const u8 = null,

    /// Pagination token. Present when more pages are available; `null` when there
    /// are no more results.
    next_token: ?[]const u8 = null,

    /// `true` when data could not be retrieved for one or more billing months. The
    /// `failedMonths` field lists which months are missing.
    partial_results: bool,

    pub const json_field_names = .{
        .credit_allocation_history_list = "creditAllocationHistoryList",
        .failed_months = "failedMonths",
        .next_token = "nextToken",
        .partial_results = "partialResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCreditAllocationHistoryInput, options: CallOptions) !GetCreditAllocationHistoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCreditAllocationHistoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.GetCreditAllocationHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCreditAllocationHistoryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetCreditAllocationHistoryOutput, body, allocator);
}
