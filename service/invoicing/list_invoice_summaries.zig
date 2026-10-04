const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InvoiceSummariesFilter = @import("invoice_summaries_filter.zig").InvoiceSummariesFilter;
const InvoiceSummariesSelector = @import("invoice_summaries_selector.zig").InvoiceSummariesSelector;
const InvoiceSummary = @import("invoice_summary.zig").InvoiceSummary;

pub const ListInvoiceSummariesInput = struct {
    /// Filters you can use to customize your invoice summary.
    filter: ?InvoiceSummariesFilter = null,

    /// The maximum number of invoice summaries a paginated response can contain.
    max_results: ?i32 = null,

    /// The token for the next set of results. (You received this token from a
    /// previous call.)
    next_token: ?[]const u8 = null,

    /// The option to retrieve details for a specific invoice by providing its
    /// unique ID. Alternatively, access information for all invoices linked to the
    /// account by providing an account ID.
    selector: InvoiceSummariesSelector,

    pub const json_field_names = .{
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .selector = "Selector",
    };
};

pub const ListInvoiceSummariesOutput = struct {
    /// List of key (summary level) invoice details without line item details.
    invoice_summaries: ?[]const InvoiceSummary = null,

    /// The token to use to retrieve the next set of results, or null if there are
    /// no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .invoice_summaries = "InvoiceSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInvoiceSummariesInput, options: CallOptions) !ListInvoiceSummariesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "invoicing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInvoiceSummariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("invoicing", "Invoicing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Invoicing.ListInvoiceSummaries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInvoiceSummariesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListInvoiceSummariesOutput, body, allocator);
}
