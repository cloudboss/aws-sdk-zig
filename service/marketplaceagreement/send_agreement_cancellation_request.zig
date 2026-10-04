const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgreementCancellationRequestReasonCode = @import("agreement_cancellation_request_reason_code.zig").AgreementCancellationRequestReasonCode;
const AgreementCancellationRequestStatus = @import("agreement_cancellation_request_status.zig").AgreementCancellationRequestStatus;

pub const SendAgreementCancellationRequestInput = struct {
    /// The unique identifier of the agreement for which the cancellation request is
    /// being submitted.
    agreement_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// An optional detailed description of the cancellation reason (1-2000
    /// characters).
    description: ?[]const u8 = null,

    /// The reason code for the cancellation request.
    reason_code: AgreementCancellationRequestReasonCode,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .client_token = "clientToken",
        .description = "description",
        .reason_code = "reasonCode",
    };
};

pub const SendAgreementCancellationRequestOutput = struct {
    /// The unique identifier for the created cancellation request.
    agreement_cancellation_request_id: ?[]const u8 = null,

    /// The unique identifier of the agreement.
    agreement_id: ?[]const u8 = null,

    /// The time when the cancellation request was created.
    created_at: ?i64 = null,

    /// The detailed description of the cancellation reason, if provided.
    description: ?[]const u8 = null,

    /// The reason code provided for the cancellation.
    reason_code: ?AgreementCancellationRequestReasonCode = null,

    /// The current status of the cancellation request. The initial status is
    /// `PENDING_APPROVAL`.
    status: ?AgreementCancellationRequestStatus = null,

    /// The time when the cancellation request was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agreement_cancellation_request_id = "agreementCancellationRequestId",
        .agreement_id = "agreementId",
        .created_at = "createdAt",
        .description = "description",
        .reason_code = "reasonCode",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendAgreementCancellationRequestInput, options: CallOptions) !SendAgreementCancellationRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendAgreementCancellationRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.SendAgreementCancellationRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendAgreementCancellationRequestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SendAgreementCancellationRequestOutput, body, allocator);
}
