const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityAccountFilter = @import("entity_account_filter.zig").EntityAccountFilter;
const EventAccountFilter = @import("event_account_filter.zig").EventAccountFilter;
const AffectedEntity = @import("affected_entity.zig").AffectedEntity;
const OrganizationAffectedEntitiesErrorItem = @import("organization_affected_entities_error_item.zig").OrganizationAffectedEntitiesErrorItem;

pub const DescribeAffectedEntitiesForOrganizationInput = struct {
    /// The locale (language) to return information in. English (en) is the default
    /// and the only supported value at this time.
    locale: ?[]const u8 = null,

    /// The maximum number of items to return in one batch, between 1 and 100,
    /// inclusive.
    max_results: ?i32 = null,

    /// If the results of a search are large, only a portion of the
    /// results are returned, and a `nextToken` pagination token is returned in the
    /// response. To
    /// retrieve the next batch of results, reissue the search request and include
    /// the returned token.
    /// When all results have been returned, the response does not contain a
    /// pagination token value.
    next_token: ?[]const u8 = null,

    /// A JSON set of elements including the `awsAccountId`, `eventArn` and a set of
    /// `statusCodes`.
    organization_entity_account_filters: ?[]const EntityAccountFilter = null,

    /// A JSON set of elements including the `awsAccountId` and the
    /// `eventArn`.
    organization_entity_filters: ?[]const EventAccountFilter = null,

    pub const json_field_names = .{
        .locale = "locale",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .organization_entity_account_filters = "organizationEntityAccountFilters",
        .organization_entity_filters = "organizationEntityFilters",
    };
};

pub const DescribeAffectedEntitiesForOrganizationOutput = struct {
    /// A JSON set of elements including the `awsAccountId` and its
    /// `entityArn`, `entityValue` and its `entityArn`,
    /// `lastUpdatedTime`, and `statusCode`.
    entities: ?[]const AffectedEntity = null,

    /// A JSON set of elements of the failed response, including the `awsAccountId`,
    /// `errorMessage`, `errorName`, and `eventArn`.
    failed_set: ?[]const OrganizationAffectedEntitiesErrorItem = null,

    /// If the results of a search are large, only a portion of the
    /// results are returned, and a `nextToken` pagination token is returned in the
    /// response. To
    /// retrieve the next batch of results, reissue the search request and include
    /// the returned token.
    /// When all results have been returned, the response does not contain a
    /// pagination token value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entities = "entities",
        .failed_set = "failedSet",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAffectedEntitiesForOrganizationInput, options: CallOptions) !DescribeAffectedEntitiesForOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "health", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAffectedEntitiesForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health", "Health", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHealth_20160804.DescribeAffectedEntitiesForOrganization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAffectedEntitiesForOrganizationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAffectedEntitiesForOrganizationOutput, body, allocator);
}
