const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Intent = @import("intent.zig").Intent;
const RequestedTerm = @import("requested_term.zig").RequestedTerm;
const TaxConfiguration = @import("tax_configuration.zig").TaxConfiguration;
const ChargeSummary = @import("charge_summary.zig").ChargeSummary;

pub const CreateAgreementRequestInput = struct {
    /// The agreement proposal signed by the proposer. The proposal includes the
    /// requested resources and the terms that outline an agreement outcome.
    ///
    /// This parameter is required if the intent is not `AMEND`.
    agreement_proposal_identifier: ?[]const u8 = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The purpose and desired outcome of the agreement request. This is a required
    /// parameter that determines how the agreement request is processed.
    ///
    /// * `NEW` – Creates a new agreement for terms in the request.
    /// * `AMEND` – Modifies an existing agreement with terms that are accepted in
    ///   the request.
    /// * `REPLACE` – Creates a new agreement with accepted terms and replaces the
    ///   existing agreement.
    intent: Intent,

    /// A list of terms that define what is being accepted as part of the agreement.
    /// Some terms require configuration.
    requested_terms: []const RequestedTerm,

    /// The agreement's identifier that the request acts upon.
    ///
    /// This parameter is required for all non-`NEW` intents (i.e., `AMEND` or
    /// `REPLACE`). Don't provide this parameter if the intent is `NEW`.
    source_agreement_identifier: ?[]const u8 = null,

    /// Configuration for tax estimation in the agreement request response.
    tax_configuration: ?TaxConfiguration = null,

    pub const json_field_names = .{
        .agreement_proposal_identifier = "agreementProposalIdentifier",
        .client_token = "clientToken",
        .intent = "intent",
        .requested_terms = "requestedTerms",
        .source_agreement_identifier = "sourceAgreementIdentifier",
        .tax_configuration = "taxConfiguration",
    };
};

pub const CreateAgreementRequestOutput = struct {
    /// The unique identifier of the agreement request created. Use this identifier
    /// with `AcceptAgreementRequest` to accept the agreement.
    agreement_request_id: ?[]const u8 = null,

    /// Provides details of the charges associated with the agreement request. This
    /// is only applicable when a request is created for `PurchaseAgreement`.
    charge_summary: ?ChargeSummary = null,

    pub const json_field_names = .{
        .agreement_request_id = "agreementRequestId",
        .charge_summary = "chargeSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAgreementRequestInput, options: CallOptions) !CreateAgreementRequestOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAgreementRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.CreateAgreementRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAgreementRequestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAgreementRequestOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
