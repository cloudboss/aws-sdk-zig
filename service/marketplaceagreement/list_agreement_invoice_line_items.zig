const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

    /// A token to retrieve the next page of results. If not present, there are no
    /// more results available.
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "awsmpcommerceservice_v20200301");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListAgreementInvoiceLineItemsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("agreement-marketplace", "Marketplace Agreement", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
