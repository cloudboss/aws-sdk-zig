const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingAdjustmentReasonCode = @import("billing_adjustment_reason_code.zig").BillingAdjustmentReasonCode;
const BillingAdjustmentStatus = @import("billing_adjustment_status.zig").BillingAdjustmentStatus;

pub const GetBillingAdjustmentRequestInput = struct {
    /// The unique identifier of the agreement associated with the billing
    /// adjustment request.
    agreement_id: []const u8,

    /// The unique identifier of the billing adjustment request.
    billing_adjustment_request_id: []const u8,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .billing_adjustment_request_id = "billingAdjustmentRequestId",
    };
};

pub const GetBillingAdjustmentRequestOutput = struct {
    /// The adjustment amount as a string representation of a decimal number.
    adjustment_amount: []const u8,

    /// The reason code for the billing adjustment.
    adjustment_reason_code: BillingAdjustmentReasonCode,

    /// The unique identifier of the agreement associated with this billing
    /// adjustment request.
    agreement_id: []const u8,

    /// The unique identifier of the billing adjustment request.
    billing_adjustment_request_id: []const u8,

    /// The date and time when the billing adjustment request was created.
    created_at: i64,

    /// The currency code for the adjustment amount (e.g., `USD`).
    currency_code: []const u8,

    /// The detailed description of the billing adjustment reason, if provided.
    description: ?[]const u8 = null,

    /// The identifier of the original invoice being adjusted.
    original_invoice_id: []const u8,

    /// The current status of the billing adjustment request.
    status: BillingAdjustmentStatus,

    /// A message providing additional context about the billing adjustment request
    /// status. This field is populated only when the status is `VALIDATION_FAILED`.
    status_message: ?[]const u8 = null,

    /// The date and time when the billing adjustment request was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .adjustment_amount = "adjustmentAmount",
        .adjustment_reason_code = "adjustmentReasonCode",
        .agreement_id = "agreementId",
        .billing_adjustment_request_id = "billingAdjustmentRequestId",
        .created_at = "createdAt",
        .currency_code = "currencyCode",
        .description = "description",
        .original_invoice_id = "originalInvoiceId",
        .status = "status",
        .status_message = "statusMessage",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBillingAdjustmentRequestInput, options: CallOptions) !GetBillingAdjustmentRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBillingAdjustmentRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.GetBillingAdjustmentRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBillingAdjustmentRequestOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetBillingAdjustmentRequestOutput, body, allocator);
}
