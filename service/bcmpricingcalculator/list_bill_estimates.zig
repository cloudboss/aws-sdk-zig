const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FilterTimestamp = @import("filter_timestamp.zig").FilterTimestamp;
const ListBillEstimatesFilter = @import("list_bill_estimates_filter.zig").ListBillEstimatesFilter;
const BillEstimateSummary = @import("bill_estimate_summary.zig").BillEstimateSummary;

pub const ListBillEstimatesInput = struct {
    /// Filter bill estimates based on the creation date.
    created_at_filter: ?FilterTimestamp = null,

    /// Filter bill estimates based on the expiration date.
    expires_at_filter: ?FilterTimestamp = null,

    /// Filters to apply to the list of bill estimates.
    filters: ?[]const ListBillEstimatesFilter = null,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// A token to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at_filter = "createdAtFilter",
        .expires_at_filter = "expiresAtFilter",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListBillEstimatesOutput = struct {
    /// The list of bill estimates for the account.
    items: ?[]const BillEstimateSummary = null,

    /// A token to retrieve the next page of results, if any.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBillEstimatesInput, options: CallOptions) !ListBillEstimatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bcm-pricing-calculator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBillEstimatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bcm-pricing-calculator", "BCM Pricing Calculator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMPricingCalculator.ListBillEstimates");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBillEstimatesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListBillEstimatesOutput, body, allocator);
}
