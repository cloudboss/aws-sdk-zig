const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Acceptor = @import("acceptor.zig").Acceptor;
const EndTimeBehavior = @import("end_time_behavior.zig").EndTimeBehavior;
const EstimatedCharges = @import("estimated_charges.zig").EstimatedCharges;
const ProposalSummary = @import("proposal_summary.zig").ProposalSummary;
const Proposer = @import("proposer.zig").Proposer;
const AgreementStatus = @import("agreement_status.zig").AgreementStatus;

pub const DescribeAgreementInput = struct {
    /// The unique identifier of the agreement.
    agreement_id: []const u8,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
    };
};

pub const DescribeAgreementOutput = struct {
    /// The date and time the offer was accepted or the agreement was created.
    ///
    /// `AcceptanceTime` and `StartTime` can differ for future dated agreements
    /// (FDAs).
    acceptance_time: ?i64 = null,

    /// The details of the party accepting the agreement terms. This is commonly the
    /// buyer for `PurchaseAgreement`.
    acceptor: ?Acceptor = null,

    /// The unique identifier of the agreement.
    agreement_id: ?[]const u8 = null,

    /// The type of agreement. Values are `PurchaseAgreement` or
    /// `VendorInsightsAgreement`.
    agreement_type: ?[]const u8 = null,

    /// The date and time when the agreement ends. The field is `null` for
    /// pay-as-you-go agreements, which don’t have end dates.
    end_time: ?i64 = null,

    /// The behavior of the agreement when it reaches its end date. For example,
    /// whether the agreement renews, and if it doesn't, the reason why.
    ///
    /// This field is present for every active agreement that has an end date. It is
    /// not present for an agreement that has no end date, because such an agreement
    /// never reaches an end time. Pay-as-you-go agreements are the most common
    /// example. It is also not present for an agreement that is no longer active.
    end_time_behavior: ?EndTimeBehavior = null,

    /// The estimated cost of the agreement.
    estimated_charges: ?EstimatedCharges = null,

    /// The unique identifier of the very first agreement in a chain of related
    /// agreements, such as renewals or replacements. It stays the same across all
    /// agreements in that chain, which lets you trace an agreement back to the
    /// original. When an agreement isn't derived from another agreement, its
    /// `InitialAgreementId` is its own `AgreementId`.
    initial_agreement_id: ?[]const u8 = null,

    /// A summary of the proposal received from the proposer.
    proposal_summary: ?ProposalSummary = null,

    /// The details of the party proposing the agreement terms. This is commonly the
    /// seller for `PurchaseAgreement`.
    proposer: ?Proposer = null,

    /// The date and time when the agreement starts.
    start_time: ?i64 = null,

    /// The current status of the agreement.
    ///
    /// Statuses include:
    ///
    /// * `ACTIVE` – The terms of the agreement are active.
    /// * `CANCELLED` – The acceptor ended the agreement before the defined end
    ///   date.
    /// * `EXPIRED` – The agreement ended on the defined end date.
    /// * `RENEWED` – The agreement was renewed into a new agreement (for example,
    ///   an auto-renewal).
    /// * `REPLACED` – The agreement was replaced using an agreement replacement
    ///   offer.
    /// * `TERMINATED` – The agreement ended before the defined end date because of
    ///   an AWS termination (for example, a payment failure).
    status: ?AgreementStatus = null,

    pub const json_field_names = .{
        .acceptance_time = "acceptanceTime",
        .acceptor = "acceptor",
        .agreement_id = "agreementId",
        .agreement_type = "agreementType",
        .end_time = "endTime",
        .end_time_behavior = "endTimeBehavior",
        .estimated_charges = "estimatedCharges",
        .initial_agreement_id = "initialAgreementId",
        .proposal_summary = "proposalSummary",
        .proposer = "proposer",
        .start_time = "startTime",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAgreementInput, options: CallOptions) !DescribeAgreementOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAgreementInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.DescribeAgreement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAgreementOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAgreementOutput, body, allocator);
}
