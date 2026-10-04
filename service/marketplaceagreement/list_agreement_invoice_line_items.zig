const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LineItemGroupBy = @import("line_item_group_by.zig").LineItemGroupBy;
const InvoiceBillingPeriod = @import("invoice_billing_period.zig").InvoiceBillingPeriod;
const InvoiceType = @import("invoice_type.zig").InvoiceType;
const AgreementInvoiceLineItemGroupSummary = @import("agreement_invoice_line_item_group_summary.zig").AgreementInvoiceLineItemGroupSummary;

pub const ListAgreementInvoiceLineItemsInput = struct {
    /// An optional filter for invoices issued after the specified timestamp.
    after_issued_time: ?i64 = null,

    /// The unique identifier of the agreement.
    agreement_id: []const u8,

    /// An optional filter for invoices issued before the specified timestamp.
    before_issued_time: ?i64 = null,

    /// Specifies a grouping strategy for line items. Currently supports
    /// `INVOICE_ID`.
    group_by: LineItemGroupBy,

    /// An optional filter for the billing period associated with the invoice.
    invoice_billing_period: ?InvoiceBillingPeriod = null,

    /// An optional filter to retrieve invoice information for a specific invoice.
    invoice_id: ?[]const u8 = null,

    /// An optional filter for the type of invoice. Valid values are `INVOICE` and
    /// `CREDIT_MEMO`.
    invoice_type: ?InvoiceType = null,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// A token to specify where to start pagination.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_issued_time = "afterIssuedTime",
        .agreement_id = "agreementId",
        .before_issued_time = "beforeIssuedTime",
        .group_by = "groupBy",
        .invoice_billing_period = "invoiceBillingPeriod",
        .invoice_id = "invoiceId",
        .invoice_type = "invoiceType",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAgreementInvoiceLineItemsOutput = struct {
    /// A list of grouped billing data objects.
    agreement_invoice_line_item_group_summaries: ?[]const AgreementInvoiceLineItemGroupSummary = null,

    /// The token used for pagination. The field is `null` if there are no more
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .agreement_invoice_line_item_group_summaries = "agreementInvoiceLineItemGroupSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAgreementInvoiceLineItemsInput, options: CallOptions) !ListAgreementInvoiceLineItemsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsmpcommerceservice_v20200301", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAgreementInvoiceLineItemsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("agreement-marketplace", "Marketplace Agreement", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.ListAgreementInvoiceLineItems");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAgreementInvoiceLineItemsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAgreementInvoiceLineItemsOutput, body, allocator);
}
