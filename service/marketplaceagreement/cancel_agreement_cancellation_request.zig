const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgreementCancellationRequestReasonCode = @import("agreement_cancellation_request_reason_code.zig").AgreementCancellationRequestReasonCode;
const AgreementCancellationRequestStatus = @import("agreement_cancellation_request_status.zig").AgreementCancellationRequestStatus;

pub const CancelAgreementCancellationRequestInput = struct {
    /// The unique identifier of the cancellation request to cancel.
    agreement_cancellation_request_id: []const u8,

    /// The unique identifier of the agreement associated with the cancellation
    /// request.
    agreement_id: []const u8,

    /// A required message explaining why the cancellation request is being
    /// withdrawn (1-2000 characters).
    cancellation_reason: []const u8,

    pub const json_field_names = .{
        .agreement_cancellation_request_id = "agreementCancellationRequestId",
        .agreement_id = "agreementId",
        .cancellation_reason = "cancellationReason",
    };
};

pub const CancelAgreementCancellationRequestOutput = struct {
    /// The unique identifier of the cancelled cancellation request.
    agreement_cancellation_request_id: ?[]const u8 = null,

    /// The unique identifier of the agreement associated with this cancellation
    /// request.
    agreement_id: ?[]const u8 = null,

    /// The date and time when the cancellation request was originally created.
    created_at: ?i64 = null,

    /// The detailed description of the original cancellation reason, if provided.
    description: ?[]const u8 = null,

    /// The original reason code provided when the cancellation request was created.
    reason_code: ?AgreementCancellationRequestReasonCode = null,

    /// The updated status of the cancellation request, which is `CANCELLED`.
    status: ?AgreementCancellationRequestStatus = null,

    /// A message providing additional context about the cancellation request
    /// status.
    status_message: ?[]const u8 = null,

    /// The date and time when the cancellation request was cancelled.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agreement_cancellation_request_id = "agreementCancellationRequestId",
        .agreement_id = "agreementId",
        .created_at = "createdAt",
        .description = "description",
        .reason_code = "reasonCode",
        .status = "status",
        .status_message = "statusMessage",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelAgreementCancellationRequestInput, options: CallOptions) !CancelAgreementCancellationRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelAgreementCancellationRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.CancelAgreementCancellationRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelAgreementCancellationRequestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CancelAgreementCancellationRequestOutput, body, allocator);
}
