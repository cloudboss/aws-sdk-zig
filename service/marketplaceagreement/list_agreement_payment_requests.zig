const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PaymentRequestStatus = @import("payment_request_status.zig").PaymentRequestStatus;
const PaymentRequestSummary = @import("payment_request_summary.zig").PaymentRequestSummary;

pub const ListAgreementPaymentRequestsInput = struct {
    /// An optional parameter to list payment requests for a specific agreement.
    agreement_id: ?[]const u8 = null,

    /// An optional parameter to list payment requests by agreement type (e.g.,
    /// `PurchaseAgreement`).
    agreement_type: ?[]const u8 = null,

    /// An optional parameter to list payment requests by catalog (e.g.,
    /// `AWSMarketplace`).
    catalog: ?[]const u8 = null,

    /// The maximum number of payment requests to return in a single response
    /// (1-50). Default is 50.
    max_results: ?i32 = null,

    /// A token to specify where to start pagination.
    next_token: ?[]const u8 = null,

    /// The party type for the payment requests. Required parameter. Use `Proposer`
    /// to list payment requests where you are the seller, or `Acceptor` to list
    /// payment requests where you are the buyer.
    party_type: []const u8,

    /// An optional parameter to list payment requests by status. Valid values
    /// include `VALIDATING`, `VALIDATION_FAILED`, `PENDING_APPROVAL`, `APPROVED`,
    /// `REJECTED`, and `CANCELLED`.
    status: ?PaymentRequestStatus = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .agreement_type = "agreementType",
        .catalog = "catalog",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .party_type = "partyType",
        .status = "status",
    };
};

pub const ListAgreementPaymentRequestsOutput = struct {
    /// An array of `PaymentRequestSummary` objects containing summary information
    /// about each payment request.
    items: ?[]const PaymentRequestSummary = null,

    /// The token used for pagination. The field is `null` if there are no more
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAgreementPaymentRequestsInput, options: CallOptions) !ListAgreementPaymentRequestsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAgreementPaymentRequestsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.ListAgreementPaymentRequests");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAgreementPaymentRequestsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListAgreementPaymentRequestsOutput, body, allocator);
}
