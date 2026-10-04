const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreatedDateFilter = @import("created_date_filter.zig").CreatedDateFilter;
const LastModifiedDate = @import("last_modified_date.zig").LastModifiedDate;
const ReviewStatus = @import("review_status.zig").ReviewStatus;
const Stage = @import("stage.zig").Stage;
const OpportunitySort = @import("opportunity_sort.zig").OpportunitySort;
const TargetCloseDateFilter = @import("target_close_date_filter.zig").TargetCloseDateFilter;
const OpportunitySummary = @import("opportunity_summary.zig").OpportunitySummary;

pub const ListOpportunitiesInput = struct {
    /// Specifies the catalog associated with the request. This field takes a string
    /// value from a predefined list: `AWS` or `Sandbox`. The catalog determines
    /// which environment the opportunities are listed in. Use `AWS` for listing
    /// real opportunities in the Amazon Web Services catalog, and `Sandbox` for
    /// testing in secure, isolated environments.
    catalog: []const u8,

    /// Filter opportunities by creation date criteria.
    created_date: ?CreatedDateFilter = null,

    /// Filters the opportunities based on the customer's company name. This allows
    /// partners to search for opportunities associated with a specific customer by
    /// matching the provided company name string.
    customer_company_name: ?[]const []const u8 = null,

    /// Filters the opportunities based on the opportunity identifier. This allows
    /// partners to retrieve specific opportunities by providing their unique
    /// identifiers, ensuring precise results.
    identifier: ?[]const []const u8 = null,

    /// Filters the opportunities based on their last modified date. This filter
    /// helps retrieve opportunities that were updated after the specified date,
    /// allowing partners to track recent changes or updates.
    last_modified_date: ?LastModifiedDate = null,

    /// Filters the opportunities based on their current lifecycle approval status.
    /// Use this filter to retrieve opportunities with statuses such as `Pending
    /// Submission`, `In Review`, `Action Required`, or `Approved`.
    life_cycle_review_status: ?[]const ReviewStatus = null,

    /// Filters the opportunities based on their lifecycle stage. This filter allows
    /// partners to retrieve opportunities at various stages in the sales cycle,
    /// such as `Qualified`, `Technical Validation`, `Business Validation`, or
    /// `Closed Won`.
    life_cycle_stage: ?[]const Stage = null,

    /// Specifies the maximum number of results to return in a single call. This
    /// limits the number of opportunities returned in the response to avoid
    /// providing too many results at once.
    ///
    /// Default: 20
    max_results: ?i32 = null,

    /// A pagination token used to retrieve the next set of results in subsequent
    /// calls. This token is included in the response only if there are additional
    /// result pages available.
    next_token: ?[]const u8 = null,

    /// An object that specifies how the response is sorted. The default
    /// `Sort.SortBy` value is `LastModifiedDate`.
    sort: ?OpportunitySort = null,

    /// Filters opportunities based on their target close date. This filter helps
    /// retrieve opportunities with an expected close date before or after a
    /// specified date.
    target_close_date: ?TargetCloseDateFilter = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .created_date = "CreatedDate",
        .customer_company_name = "CustomerCompanyName",
        .identifier = "Identifier",
        .last_modified_date = "LastModifiedDate",
        .life_cycle_review_status = "LifeCycleReviewStatus",
        .life_cycle_stage = "LifeCycleStage",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort = "Sort",
        .target_close_date = "TargetCloseDate",
    };
};

pub const ListOpportunitiesOutput = struct {
    /// A pagination token used to retrieve the next set of results in subsequent
    /// calls. This token is included in the response only if there are additional
    /// result pages available.
    next_token: ?[]const u8 = null,

    /// An array that contains minimal details for opportunities that match the
    /// request criteria. This summary view provides a quick overview of relevant
    /// opportunities.
    opportunity_summaries: ?[]const OpportunitySummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .opportunity_summaries = "OpportunitySummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOpportunitiesInput, options: CallOptions) !ListOpportunitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOpportunitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListOpportunities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOpportunitiesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListOpportunitiesOutput, body, allocator);
}
