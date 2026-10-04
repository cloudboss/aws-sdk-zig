const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PaymentRequestStatus = @import("payment_request_status.zig").PaymentRequestStatus;

pub const SendAgreementPaymentRequestInput = struct {
    /// The unique identifier of the agreement for which the payment request is
    /// being submitted. Use `GetAgreementTerms` to retrieve agreement term details.
    agreement_id: []const u8,

    /// The amount requested to be charged to the buyer, positive decimal value in
    /// the currency of the accepted term.
    ///
    /// A `ValidationException` is returned if the `chargeAmount` exceeds the
    /// available balance, if the agreement doesn't have an active
    /// `VariablePaymentTerm`, or if the `termId` is invalid.
    charge_amount: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// An optional detailed description of the payment request (1-2000 characters).
    description: ?[]const u8 = null,

    /// A descriptive name for the payment request (5-64 characters).
    name: []const u8,

    /// The unique identifier of the `VariablePaymentTerm` for the agreement that
    /// the payment request is being sent for.
    term_id: []const u8,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .charge_amount = "chargeAmount",
        .client_token = "clientToken",
        .description = "description",
        .name = "name",
        .term_id = "termId",
    };
};

pub const SendAgreementPaymentRequestOutput = struct {
    /// The agreement identifier for this payment request.
    agreement_id: ?[]const u8 = null,

    /// The amount being charged to the buyer.
    charge_amount: ?[]const u8 = null,

    /// The time when the payment request was created.
    created_at: ?i64 = null,

    /// The currency code for the charge amount (e.g., `USD`).
    currency_code: ?[]const u8 = null,

    /// The detailed description of the payment request, if provided.
    description: ?[]const u8 = null,

    /// The descriptive name of the payment request.
    name: ?[]const u8 = null,

    /// The unique identifier for the sent payment request.
    payment_request_id: ?[]const u8 = null,

    /// The current status of the payment request. The initial status is
    /// `PENDING_APPROVAL`.
    status: ?PaymentRequestStatus = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .charge_amount = "chargeAmount",
        .created_at = "createdAt",
        .currency_code = "currencyCode",
        .description = "description",
        .name = "name",
        .payment_request_id = "paymentRequestId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendAgreementPaymentRequestInput, options: CallOptions) !SendAgreementPaymentRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendAgreementPaymentRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.SendAgreementPaymentRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendAgreementPaymentRequestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SendAgreementPaymentRequestOutput, body, allocator);
}
