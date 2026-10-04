const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgreementCancellationRequestStatus = @import("agreement_cancellation_request_status.zig").AgreementCancellationRequestStatus;
const AgreementCancellationRequestSummary = @import("agreement_cancellation_request_summary.zig").AgreementCancellationRequestSummary;

pub const ListAgreementCancellationRequestsInput = struct {
    /// An optional parameter to filter cancellation requests for a specific
    /// agreement.
    agreement_id: ?[]const u8 = null,

    /// An optional parameter to filter cancellation requests by agreement type
    /// (e.g., `PurchaseAgreement`).
    agreement_type: ?[]const u8 = null,

    /// An optional parameter to filter cancellation requests by catalog (e.g.,
    /// `AWSMarketplace`).
    catalog: ?[]const u8 = null,

    /// The maximum number of cancellation requests to return in the response.
    max_results: ?i32 = null,

    /// A token to specify where to start pagination.
    next_token: ?[]const u8 = null,

    /// The party type for the cancellation requests. Required parameter. Use
    /// `Proposer` to list cancellation requests where you are the seller, or
    /// `Acceptor` to list cancellation requests where you are the buyer.
    party_type: []const u8,

    /// An optional parameter to filter cancellation requests by status.
    status: ?AgreementCancellationRequestStatus = null,

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

pub const ListAgreementCancellationRequestsOutput = struct {
    /// An array of `AgreementCancellationRequestSummary` objects containing summary
    /// information about each cancellation request.
    items: ?[]const AgreementCancellationRequestSummary = null,

    /// The token used for pagination. The field is `null` if there are no more
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAgreementCancellationRequestsInput, options: CallOptions) !ListAgreementCancellationRequestsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAgreementCancellationRequestsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.ListAgreementCancellationRequests");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAgreementCancellationRequestsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAgreementCancellationRequestsOutput, body, allocator);
}
