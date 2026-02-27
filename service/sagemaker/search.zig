const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CrossAccountFilterOption = @import("cross_account_filter_option.zig").CrossAccountFilterOption;
const ResourceType = @import("resource_type.zig").ResourceType;
const SearchExpression = @import("search_expression.zig").SearchExpression;
const SearchSortOrder = @import("search_sort_order.zig").SearchSortOrder;
const VisibilityConditions = @import("visibility_conditions.zig").VisibilityConditions;
const SearchRecord = @import("search_record.zig").SearchRecord;
const TotalHits = @import("total_hits.zig").TotalHits;

pub const SearchInput = struct {
    /// A cross account filter option. When the value is `"CrossAccount"` the search
    /// results will only include resources made discoverable to you from other
    /// accounts. When the value is `"SameAccount"` or `null` the search results
    /// will only include resources from your account. Default is `null`. For more
    /// information on searching for resources made discoverable to your account,
    /// see [ Search discoverable
    /// resources](https://docs.aws.amazon.com/sagemaker/latest/dg/feature-store-cross-account-discoverability-use.html) in the SageMaker Developer Guide. The maximum number of `ResourceCatalog`s viewable is 1000.
    cross_account_filter_option: ?CrossAccountFilterOption = null,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// If more than `MaxResults` resources match the specified `SearchExpression`,
    /// the response includes a `NextToken`. The `NextToken` can be passed to the
    /// next `SearchRequest` to continue retrieving results.
    next_token: ?[]const u8 = null,

    /// The name of the SageMaker resource to search for.
    resource: ResourceType,

    /// A Boolean conditional statement. Resources must satisfy this condition to be
    /// included in search results. You must provide at least one subexpression,
    /// filter, or nested filter. The maximum number of recursive `SubExpressions`,
    /// `NestedFilters`, and `Filters` that can be included in a `SearchExpression`
    /// object is 50.
    search_expression: ?SearchExpression = null,

    /// The name of the resource property used to sort the `SearchResults`. The
    /// default is `LastModifiedTime`.
    sort_by: ?[]const u8 = null,

    /// How `SearchResults` are ordered. Valid values are `Ascending` or
    /// `Descending`. The default is `Descending`.
    sort_order: ?SearchSortOrder = null,

    /// Limits the results of your search request to the resources that you can
    /// access.
    visibility_conditions: ?[]const VisibilityConditions = null,

    pub const json_field_names = .{
        .cross_account_filter_option = "CrossAccountFilterOption",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource = "Resource",
        .search_expression = "SearchExpression",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .visibility_conditions = "VisibilityConditions",
    };
};

pub const SearchOutput = struct {
    /// If the result of the previous `Search` request was truncated, the response
    /// includes a NextToken. To retrieve the next set of results, use the token in
    /// the next request.
    next_token: ?[]const u8 = null,

    /// A list of `SearchRecord` objects.
    results: ?[]const SearchRecord = null,

    /// The total number of matching results.
    total_hits: ?TotalHits = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .results = "Results",
        .total_hits = "TotalHits",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchInput, options: Options) !SearchOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: SearchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.Search");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !SearchOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
