const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListBillEstimateLineItemsFilter = @import("list_bill_estimate_line_items_filter.zig").ListBillEstimateLineItemsFilter;
const BillEstimateLineItemSummary = @import("bill_estimate_line_item_summary.zig").BillEstimateLineItemSummary;

pub const ListBillEstimateLineItemsInput = struct {
    /// The unique identifier of the bill estimate to list line items for.
    bill_estimate_id: []const u8,

    /// Filters to apply to the list of line items.
    filters: ?[]const ListBillEstimateLineItemsFilter = null,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// A token to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bill_estimate_id = "billEstimateId",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListBillEstimateLineItemsOutput = struct {
    /// The list of line items associated with the bill estimate.
    items: ?[]const BillEstimateLineItemSummary = null,

    /// A token to retrieve the next page of results, if any.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBillEstimateLineItemsInput, options: CallOptions) !ListBillEstimateLineItemsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBillEstimateLineItemsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMPricingCalculator.ListBillEstimateLineItems");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBillEstimateLineItemsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListBillEstimateLineItemsOutput, body, allocator);
}
