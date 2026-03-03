const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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
    /// * `PartyType` – The party type of the caller. For agreements where the
    ///   caller is the proposer, use the `Proposer` filter.
    /// * `AcceptorAccountId` – The AWS account ID of the party accepting the
    ///   agreement terms.
    /// * `OfferId` – The unique identifier of the offer in which the terms are
    ///   registered in the agreement token.
    /// * `Status` – The current status of the agreement. Values include `ACTIVE`,
    ///   `ARCHIVED`, `CANCELLED`, `EXPIRED`, `RENEWED`, `REPLACED`, and
    ///   `TERMINATED`.
    /// * `BeforeEndTime` – A date used to filter agreements with a date before the
    ///   `endTime` of an agreement.
    /// * `AfterEndTime` – A date used to filter agreements with a date after the
    ///   `endTime` of an agreement.
    /// * `AgreementType` – The type of agreement. Supported value includes
    ///   `PurchaseAgreement`.
    /// * `OfferSetId` – A unique identifier for the offer set containing this
    ///   offer. All agreements created from offers in this set include this
    ///   identifier as context.
    filters: ?[]const Filter = null,

    /// The maximum number of agreements to return in the response.
    max_results: ?i32 = null,

    /// A token to specify where to start pagination.
    next_token: ?[]const u8 = null,

    /// An object that contains the `SortBy` and `SortOrder` attributes. Only
    /// `EndTime` is supported for `SearchAgreements`. The default sort is `EndTime`
    /// descending.
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchAgreementsInput, options: Options) !SearchAgreementsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "marketplaceagreement");

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchAgreementsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("marketplaceagreement", "Marketplace Agreement", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.SearchAgreements");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchAgreementsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchAgreementsOutput, body, allocator);
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
