const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgreementCancellationRequestReasonCode = @import("agreement_cancellation_request_reason_code.zig").AgreementCancellationRequestReasonCode;
const AgreementCancellationRequestStatus = @import("agreement_cancellation_request_status.zig").AgreementCancellationRequestStatus;

pub const AcceptAgreementCancellationRequestInput = struct {
    /// The unique identifier of the cancellation request to accept.
    agreement_cancellation_request_id: []const u8,

    /// The unique identifier of the agreement associated with the cancellation
    /// request.
    agreement_id: []const u8,

    pub const json_field_names = .{
        .agreement_cancellation_request_id = "agreementCancellationRequestId",
        .agreement_id = "agreementId",
    };
};

pub const AcceptAgreementCancellationRequestOutput = struct {
    /// The unique identifier of the accepted cancellation request.
    agreement_cancellation_request_id: ?[]const u8 = null,

    /// The unique identifier of the agreement associated with this cancellation
    /// request.
    agreement_id: ?[]const u8 = null,

    /// The date and time when the cancellation request was originally created.
    created_at: ?i64 = null,

    /// The detailed description of the cancellation reason, if provided.
    description: ?[]const u8 = null,

    /// The original reason code provided when the cancellation request was created.
    reason_code: ?AgreementCancellationRequestReasonCode = null,

    /// The updated status of the cancellation request, which is `APPROVED`.
    status: ?AgreementCancellationRequestStatus = null,

    /// The date and time when the cancellation request was accepted.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcceptAgreementCancellationRequestInput, options: CallOptions) !AcceptAgreementCancellationRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AcceptAgreementCancellationRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.AcceptAgreementCancellationRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcceptAgreementCancellationRequestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AcceptAgreementCancellationRequestOutput, body, allocator);
}
