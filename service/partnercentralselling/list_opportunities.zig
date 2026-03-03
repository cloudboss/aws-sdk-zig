const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CreatedDateFilter = @import("created_date_filter.zig").CreatedDateFilter;
const LastModifiedDate = @import("last_modified_date.zig").LastModifiedDate;
const ReviewStatus = @import("review_status.zig").ReviewStatus;
const Stage = @import("stage.zig").Stage;
const OpportunitySort = @import("opportunity_sort.zig").OpportunitySort;
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

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentralselling");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOpportunitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentralselling", "PartnerCentral Selling", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListOpportunities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOpportunitiesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListOpportunitiesOutput, body, allocator);
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
