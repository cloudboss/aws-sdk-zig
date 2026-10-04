const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActiveTimeRange = @import("active_time_range.zig").ActiveTimeRange;
const BillingViewType = @import("billing_view_type.zig").BillingViewType;
const StringSearch = @import("string_search.zig").StringSearch;
const BillingViewListElement = @import("billing_view_list_element.zig").BillingViewListElement;

pub const ListBillingViewsInput = struct {
    /// The time range for the billing views listed. `PRIMARY` billing view is
    /// always listed. `BILLING_GROUP` billing views are listed for time ranges when
    /// the associated billing group resource in Billing Conductor is active. The
    /// time range must be within one calendar month.
    active_time_range: ?ActiveTimeRange = null,

    /// The Amazon Resource Name (ARN) that can be used to uniquely identify the
    /// billing view.
    arns: ?[]const []const u8 = null,

    /// The type of billing view.
    billing_view_types: ?[]const BillingViewType = null,

    /// The maximum number of billing views to retrieve. Default is 100.
    max_results: ?i32 = null,

    /// Filters the list of billing views by name. You can specify search criteria
    /// to match billing view names based on the search option provided.
    names: ?[]const StringSearch = null,

    /// The pagination token that is used on subsequent calls to list billing views.
    next_token: ?[]const u8 = null,

    /// The list of owners of the billing view.
    owner_account_id: ?[]const u8 = null,

    /// Filters the results to include only billing views that use the specified
    /// account as a source.
    source_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_time_range = "activeTimeRange",
        .arns = "arns",
        .billing_view_types = "billingViewTypes",
        .max_results = "maxResults",
        .names = "names",
        .next_token = "nextToken",
        .owner_account_id = "ownerAccountId",
        .source_account_id = "sourceAccountId",
    };
};

pub const ListBillingViewsOutput = struct {
    /// A list of `BillingViewListElement` retrieved.
    billing_views: ?[]const BillingViewListElement = null,

    /// The pagination token to use on subsequent calls to list billing views.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_views = "billingViews",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBillingViewsInput, options: CallOptions) !ListBillingViewsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBillingViewsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.ListBillingViews");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBillingViewsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListBillingViewsOutput, body, allocator);
}
