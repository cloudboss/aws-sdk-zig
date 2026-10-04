const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const Sort = @import("sort.zig").Sort;
const AgreementViewSummary = @import("agreement_view_summary.zig").AgreementViewSummary;

pub const SearchAgreementsInput = struct {
    /// The catalog in which the agreement was created.
    catalog: ?[]const u8 = null,

    /// The filter name and value pair used to return a specific list of results.
    ///
    /// The following filters are supported:
    ///
    /// * `ResourceIdentifier` – The unique identifier of the resource.
    /// * `ResourceType` – Type of the resource, which is the product (`AmiProduct`,
    ///   `ContainerProduct`, `SaaSProduct`, `ProfessionalServicesProduct`, or
    ///   `MachineLearningProduct`).
    /// * `PartyType` – The party type of the caller. Use `Proposer` or `Acceptor`.
    /// * `AcceptorAccountId` – The AWS account ID of the party accepting the
    ///   agreement terms.
    /// * `OfferId` – The unique identifier of the offer in which the terms are
    ///   registered in the agreement token.
    /// * `Status` – The current status of the agreement. Values include `ACTIVE`,
    ///   `CANCELLED`, `EXPIRED`, `RENEWED`, `REPLACED`, and `TERMINATED`.
    /// * `BeforeEndTime` – A date used to filter agreements with a date before the
    ///   `endTime` of an agreement.
    /// * `AfterEndTime` – A date used to filter agreements with a date after the
    ///   `endTime` of an agreement.
    /// * `BeforeStartTime` – A date used to filter agreements with a date before
    ///   the `startTime` of an agreement.
    /// * `AfterStartTime` – A date used to filter agreements with a date after the
    ///   `startTime` of an agreement.
    /// * `BeforeLastUpdateTime` – A date used to filter agreements with a date
    ///   before the `lastUpdateTime` of an agreement.
    /// * `AfterLastUpdateTime` – A date used to filter agreements with a date after
    ///   the `lastUpdateTime` of an agreement.
    /// * `AgreementType` – The type of agreement. Supported value includes
    ///   `PurchaseAgreement`.
    /// * `OfferSetId` – A unique identifier for the offer set containing this
    ///   offer. All agreements created from offers in this set include this
    ///   identifier as context.
    /// * `EndTimeBehaviorType` – What happens to the agreement when it reaches its
    ///   end date. Values include `RENEW`, `REPLACE`, and `EXPIRE`.
    /// * `EndTimeBehaviorReasonCode` – The reason why the agreement doesn't renew
    ///   at its end date. Values include `PROPOSER_RENEW_OPTED_OUT`,
    ///   `ACCEPTOR_RENEW_OPTED_OUT`, `NO_RENEWAL_TERM`, and
    ///   `RENEWAL_LIMIT_EXHAUSTED`.
    /// * `InitialAgreementId` – The unique identifier of the very first agreement
    ///   in a chain of related agreements. Use this filter to return every
    ///   agreement in the same chain.
    /// * `LicenseArn` – The Amazon Resource Name (ARN) of the AWS License Manager
    ///   license associated with an entitlement granted by the agreement.
    ///
    /// A proposer can use any combination of the preceding filters along with
    /// `AgreementType`, which is required.
    ///
    /// The following filter combinations are supported when the `PartyType` is
    /// `Acceptor`:
    ///
    /// * `AgreementType`
    /// * `AgreementType` + `Status`
    /// * `AgreementType` + `EndTime`
    /// * `AgreementType` + `Status` + `EndTime`
    /// * `AgreementType` + `ResourceIdentifier`
    /// * `AgreementType` + `ResourceIdentifier` + `EndTime`
    /// * `AgreementType` + `ResourceIdentifier` + `Status`
    /// * `AgreementType` + `ResourceIdentifier` + `Status` + `EndTime`
    /// * `AgreementType` + `ResourceType`
    /// * `AgreementType` + `ResourceType` + `EndTime`
    /// * `AgreementType` + `OfferId`
    /// * `AgreementType` + `OfferId` + `EndTime`
    /// * `AgreementType` + `OfferId` + `Status`
    /// * `AgreementType` + `OfferId` + `Status` + `EndTime`
    /// * `AgreementType` + `OfferSetId`
    /// * `AgreementType` + `OfferSetId` + `EndTime`
    /// * `AgreementType` + `OfferSetId` + `Status`
    /// * `AgreementType` + `OfferSetId` + `Status` + `EndTime`
    ///
    /// To filter by `EndTime`, you can use `BeforeEndTime`, `AfterEndTime`, or
    /// both.
    filters: ?[]const Filter = null,

    /// The maximum number of agreements to return in the response.
    max_results: ?i32 = null,

    /// A token to specify where to start pagination.
    next_token: ?[]const u8 = null,

    /// An object that contains the `SortBy` and `SortOrder` attributes. For
    /// `SearchAgreements`, `SortBy` supports `EndTime` for both party types, and
    /// `StartTime` and `LastUpdateTime` only when `PartyType` is `Proposer`. The
    /// default `SortBy` value is `EndTime`.
    sort: ?Sort = null,

    pub const json_field_names = .{
        .catalog = "catalog",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort = "sort",
    };
};

pub const SearchAgreementsOutput = struct {
    /// A summary of the agreement, including top-level attributes (for example, the
    /// agreement ID, proposer, and acceptor).
    agreement_view_summaries: ?[]const AgreementViewSummary = null,

    /// The token used for pagination. The field is `null` if there are no more
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .agreement_view_summaries = "agreementViewSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchAgreementsInput, options: CallOptions) !SearchAgreementsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchAgreementsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.SearchAgreements");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchAgreementsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchAgreementsOutput, body, allocator);
}
