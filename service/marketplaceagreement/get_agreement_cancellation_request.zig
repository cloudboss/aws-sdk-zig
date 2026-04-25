const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AgreementCancellationRequestReasonCode = @import("agreement_cancellation_request_reason_code.zig").AgreementCancellationRequestReasonCode;
const AgreementCancellationRequestStatus = @import("agreement_cancellation_request_status.zig").AgreementCancellationRequestStatus;

pub const GetAgreementCancellationRequestInput = struct {
    /// The unique identifier of the cancellation request.
    agreement_cancellation_request_id: []const u8,

    /// The unique identifier of the agreement associated with the cancellation
    /// request.
    agreement_id: []const u8,

    pub const json_field_names = .{
        .agreement_cancellation_request_id = "agreementCancellationRequestId",
        .agreement_id = "agreementId",
    };
};

pub const GetAgreementCancellationRequestOutput = struct {
    /// The unique identifier of the cancellation request.
    agreement_cancellation_request_id: ?[]const u8 = null,

    /// The unique identifier of the agreement associated with this cancellation
    /// request. Use `DescribeAgreement` to retrieve full agreement details.
    agreement_id: ?[]const u8 = null,

    /// The date and time when the cancellation request was created, as a POSIX
    /// timestamp (Unix epoch seconds).
    created_at: ?i64 = null,

    /// The detailed description of the cancellation reason, if provided.
    description: ?[]const u8 = null,

    /// The reason code provided for the cancellation.
    reason_code: ?AgreementCancellationRequestReasonCode = null,

    /// The current status of the cancellation request. Possible values include
    /// `PENDING_APPROVAL`, `APPROVED`, `REJECTED`, `CANCELLED`, and
    /// `VALIDATION_FAILED`.
    status: ?AgreementCancellationRequestStatus = null,

    /// A message providing additional context about the cancellation request
    /// status.
    status_message: ?[]const u8 = null,

    /// The date and time when the cancellation request was last updated, as a POSIX
    /// timestamp (Unix epoch seconds).
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAgreementCancellationRequestInput, options: CallOptions) !GetAgreementCancellationRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAgreementCancellationRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.GetAgreementCancellationRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAgreementCancellationRequestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAgreementCancellationRequestOutput, body, allocator);
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
