const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BusinessSupportAccountCharge = @import("business_support_account_charge.zig").BusinessSupportAccountCharge;

pub const ListBusinessSupportAccountChargesInput = struct {
    /// The linked account ID to filter results to a specific account. If you don't
    /// specify a value, the response includes charges for all linked accounts.
    account_id: ?[]const u8 = null,

    /// The billing month to retrieve Business Support charges for, in YYYY-MM
    /// format. You can request the current month (charges will be estimated) or a
    /// past month (charges will be finalized).
    billing_month: []const u8,

    /// The maximum number of results to return per page. Default is 100.
    max_results: ?i32 = null,

    /// The pagination token for the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .billing_month = "billingMonth",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListBusinessSupportAccountChargesOutput = struct {
    /// The list of Business Support charges per linked account.
    account_charges: ?[]const BusinessSupportAccountCharge = null,

    /// The total number of linked accounts with Business Support charges in the
    /// billing month.
    account_count: i32,

    /// The billing month for the returned charges, in YYYY-MM format.
    billing_month: []const u8,

    /// Specifies whether the Support charge amount is estimated. When false, the
    /// charge amount is finalized.
    is_estimated: bool,

    /// The pagination token for the next page of results.
    next_token: ?[]const u8 = null,

    /// The total Business Support charge amount for all accounts in the billing
    /// month.
    total_support_charge: []const u8,

    /// The total Support-eligible spend from all accounts in the billing month.
    /// This includes eligible spend from usage of Amazon Web Services.
    total_support_eligible_spend: []const u8,

    pub const json_field_names = .{
        .account_charges = "accountCharges",
        .account_count = "accountCount",
        .billing_month = "billingMonth",
        .is_estimated = "isEstimated",
        .next_token = "nextToken",
        .total_support_charge = "totalSupportCharge",
        .total_support_eligible_spend = "totalSupportEligibleSpend",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBusinessSupportAccountChargesInput, options: CallOptions) !ListBusinessSupportAccountChargesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBusinessSupportAccountChargesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.ListBusinessSupportAccountCharges");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBusinessSupportAccountChargesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListBusinessSupportAccountChargesOutput, body, allocator);
}
