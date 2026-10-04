const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
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
