const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PaymentRequestStatus = @import("payment_request_status.zig").PaymentRequestStatus;

pub const AcceptAgreementPaymentRequestInput = struct {
    /// The unique identifier of the agreement associated with the payment request.
    agreement_id: []const u8,

    /// The unique identifier of the payment request to accept.
    payment_request_id: []const u8,

    /// An optional purchase order reference that buyers can provide to associate
    /// the payment request with their internal purchase order system.
    purchase_order_reference: ?[]const u8 = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .payment_request_id = "paymentRequestId",
        .purchase_order_reference = "purchaseOrderReference",
    };
};

pub const AcceptAgreementPaymentRequestOutput = struct {
    /// The unique identifier of the agreement associated with this payment request.
    agreement_id: ?[]const u8 = null,

    /// The amount that was approved to be charged.
    charge_amount: ?[]const u8 = null,

    /// The date and time when the payment request was originally created.
    created_at: ?i64 = null,

    /// The currency code for the charge amount.
    currency_code: ?[]const u8 = null,

    /// The detailed description of the payment request, if provided.
    description: ?[]const u8 = null,

    /// The descriptive name of the payment request.
    name: ?[]const u8 = null,

    /// The unique identifier of the accepted payment request.
    payment_request_id: ?[]const u8 = null,

    /// The updated status of the payment request, which is `APPROVED`.
    status: ?PaymentRequestStatus = null,

    /// The date and time when the payment request was accepted.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .charge_amount = "chargeAmount",
        .created_at = "createdAt",
        .currency_code = "currencyCode",
        .description = "description",
        .name = "name",
        .payment_request_id = "paymentRequestId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcceptAgreementPaymentRequestInput, options: CallOptions) !AcceptAgreementPaymentRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AcceptAgreementPaymentRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.AcceptAgreementPaymentRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcceptAgreementPaymentRequestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AcceptAgreementPaymentRequestOutput, body, allocator);
}
