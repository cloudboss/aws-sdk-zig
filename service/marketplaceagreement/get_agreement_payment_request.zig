const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PaymentRequestStatus = @import("payment_request_status.zig").PaymentRequestStatus;

pub const GetAgreementPaymentRequestInput = struct {
    /// The unique identifier of the agreement associated with the payment request.
    agreement_id: []const u8,

    /// The identifier of the payment request.
    payment_request_id: []const u8,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .payment_request_id = "paymentRequestId",
    };
};

pub const GetAgreementPaymentRequestOutput = struct {
    /// The unique identifier of the agreement associated with this payment request.
    /// Use `DescribeAgreement` to retrieve full agreement details.
    agreement_id: ?[]const u8 = null,

    /// The amount charged or to be charged to the buyer.
    charge_amount: ?[]const u8 = null,

    /// The unique identifier of the charge created after the payment request is
    /// approved. This field is only present for approved payment requests and
    /// follows the pattern `ch-[a-zA-Z0-9]+`.
    charge_id: ?[]const u8 = null,

    /// The date and time when the payment request was created, in ISO 8601 format.
    created_at: ?i64 = null,

    /// The currency code for the charge amount.
    currency_code: ?[]const u8 = null,

    /// The detailed description of the payment request, if provided.
    description: ?[]const u8 = null,

    /// The descriptive name of the payment request.
    name: ?[]const u8 = null,

    /// The unique identifier of the payment request.
    payment_request_id: ?[]const u8 = null,

    /// The current status of the payment request. Possible values include:
    ///
    /// * `VALIDATING` – The payment request is being validated against agreement
    ///   terms.
    /// * `VALIDATION_FAILED` – The payment request failed validation.
    /// * `PENDING_APPROVAL` – The payment request is awaiting buyer action.
    /// * `APPROVED` – The buyer has approved the payment request.
    /// * `REJECTED` – The buyer has rejected the payment request.
    /// * `CANCELLED` – The seller has cancelled the payment request.
    status: ?PaymentRequestStatus = null,

    /// An optional message providing additional context about the payment request
    /// status, such as a rejection reason or validation failure details.
    status_message: ?[]const u8 = null,

    /// The date and time when the payment request was last updated, in ISO 8601
    /// format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .charge_amount = "chargeAmount",
        .charge_id = "chargeId",
        .created_at = "createdAt",
        .currency_code = "currencyCode",
        .description = "description",
        .name = "name",
        .payment_request_id = "paymentRequestId",
        .status = "status",
        .status_message = "statusMessage",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAgreementPaymentRequestInput, options: CallOptions) !GetAgreementPaymentRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAgreementPaymentRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.GetAgreementPaymentRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAgreementPaymentRequestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAgreementPaymentRequestOutput, body, allocator);
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
