const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeFilter = @import("attribute_filter.zig").AttributeFilter;
const CollapseConfiguration = @import("collapse_configuration.zig").CollapseConfiguration;
const DocumentRelevanceConfiguration = @import("document_relevance_configuration.zig").DocumentRelevanceConfiguration;
const Facet = @import("facet.zig").Facet;
const QueryResultType = @import("query_result_type.zig").QueryResultType;
const SortingConfiguration = @import("sorting_configuration.zig").SortingConfiguration;
const SpellCorrectionConfiguration = @import("spell_correction_configuration.zig").SpellCorrectionConfiguration;
const UserContext = @import("user_context.zig").UserContext;
const FacetResult = @import("facet_result.zig").FacetResult;
const FeaturedResultsItem = @import("featured_results_item.zig").FeaturedResultsItem;
const QueryResultItem = @import("query_result_item.zig").QueryResultItem;
const SpellCorrectedQuery = @import("spell_corrected_query.zig").SpellCorrectedQuery;
const Warning = @import("warning.zig").Warning;

pub const QueryInput = struct {
    /// Filters search results by document fields/attributes. You can only provide
    /// one attribute
    /// filter; however, the `AndAllFilters`, `NotFilter`, and
    /// `OrAllFilters` parameters contain a list of other filters.
    ///
    /// The `AttributeFilter` parameter means you can create a set of filtering
    /// rules
    /// that a document must satisfy to be included in the query results.
    ///
    /// For Amazon Kendra Gen AI Enterprise Edition indices use `AttributeFilter` to
    /// enable document filtering for end users using `_email_id` or include public
    /// documents (`_email_id=null`).
    attribute_filter: ?AttributeFilter = null,

    /// Provides configuration to determine how to group results by document
    /// attribute value,
    /// and how to display them (collapsed or expanded) under a designated primary
    /// document for
    /// each group.
    collapse_configuration: ?CollapseConfiguration = null,

    /// Overrides relevance tuning configurations of fields/attributes set at the
    /// index
    /// level.
    ///
    /// If you use this API to override the relevance tuning configured at the index
    /// level, but
    /// there is no relevance tuning configured at the index level, then Amazon
    /// Kendra does
    /// not apply any relevance tuning.
    ///
    /// If there is relevance tuning configured for fields at the index level, and
    /// you use this
    /// API to override only some of these fields, then for the fields you did not
    /// override, the
    /// importance is set to 1.
    document_relevance_override_configurations: ?[]const DocumentRelevanceConfiguration = null,

    /// An array of documents fields/attributes for faceted search. Amazon Kendra
    /// returns a
    /// count for each field key specified. This helps your users narrow their
    /// search.
    facets: ?[]const Facet = null,

    /// The identifier of the index for the search.
    index_id: []const u8,

    /// Query results are returned in pages the size of the `PageSize` parameter. By
    /// default, Amazon Kendra returns the first page of results. Use this parameter
    /// to get
    /// result pages after the first one.
    page_number: ?i32 = null,

    /// Sets the number of results that are returned in each page of results. The
    /// default page
    /// size is 10. The maximum number of results returned is 100. If you ask for
    /// more than 100
    /// results, only 100 are returned.
    page_size: ?i32 = null,

    /// Sets the type of query result or response. Only results for the specified
    /// type are
    /// returned.
    query_result_type_filter: ?QueryResultType = null,

    /// The input query text for the search. Amazon Kendra truncates queries at 30
    /// token
    /// words, which excludes punctuation and stop words. Truncation still applies
    /// if you use
    /// Boolean or more advanced, complex queries. For example, `Timeoff AND October
    /// AND
    /// Category:HR` is counted as 3 tokens: `timeoff`, `october`,
    /// `hr`. For more information, see [Searching with advanced query
    /// syntax](https://docs.aws.amazon.com/kendra/latest/dg/searching-example.html#searching-index-query-syntax) in the Amazon Kendra Developer Guide.
    query_text: ?[]const u8 = null,

    /// An array of document fields/attributes to include in the response. You can
    /// limit the
    /// response to include certain document fields. By default, all document
    /// attributes are
    /// included in the response.
    requested_document_attributes: ?[]const []const u8 = null,

    /// Provides information that determines how the results of the query are
    /// sorted. You can
    /// set the field that Amazon Kendra should sort the results on, and specify
    /// whether the
    /// results should be sorted in ascending or descending order. In the case of
    /// ties in sorting
    /// the results, the results are sorted by relevance.
    ///
    /// If you don't provide sorting configuration, the results are sorted by the
    /// relevance that
    /// Amazon Kendra determines for the result.
    sorting_configuration: ?SortingConfiguration = null,

    /// Provides configuration information to determine how the results of a query
    /// are
    /// sorted.
    ///
    /// You can set upto 3 fields that Amazon Kendra should sort the results on, and
    /// specify whether the results should be sorted in ascending or descending
    /// order. The sort
    /// field quota can be increased.
    ///
    /// If you don't provide a sorting configuration, the results are sorted by the
    /// relevance
    /// that Amazon Kendra determines for the result. In the case of ties in sorting
    /// the
    /// results, the results are sorted by relevance.
    sorting_configurations: ?[]const SortingConfiguration = null,

    /// Enables suggested spell corrections for queries.
    spell_correction_configuration: ?SpellCorrectionConfiguration = null,

    /// The user context token or user and group information.
    user_context: ?UserContext = null,

    /// Provides an identifier for a specific user. The `VisitorId` should be a
    /// unique identifier, such as a GUID. Don't use personally identifiable
    /// information, such as
    /// the user's email address, as the `VisitorId`.
    visitor_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_filter = "AttributeFilter",
        .collapse_configuration = "CollapseConfiguration",
        .document_relevance_override_configurations = "DocumentRelevanceOverrideConfigurations",
        .facets = "Facets",
        .index_id = "IndexId",
        .page_number = "PageNumber",
        .page_size = "PageSize",
        .query_result_type_filter = "QueryResultTypeFilter",
        .query_text = "QueryText",
        .requested_document_attributes = "RequestedDocumentAttributes",
        .sorting_configuration = "SortingConfiguration",
        .sorting_configurations = "SortingConfigurations",
        .spell_correction_configuration = "SpellCorrectionConfiguration",
        .user_context = "UserContext",
        .visitor_id = "VisitorId",
    };
};

pub const QueryOutput = struct {
    /// Contains the facet results. A `FacetResult` contains the counts for each
    /// field/attribute key that was specified in the `Facets` input parameter.
    facet_results: ?[]const FacetResult = null,

    /// The list of featured result items. Featured results are displayed at the top
    /// of the
    /// search results page, placed above all other results for certain queries. If
    /// there's an
    /// exact match of a query, then certain documents are featured in the search
    /// results.
    featured_results_items: ?[]const FeaturedResultsItem = null,

    /// The identifier for the search. You also use `QueryId` to identify the search
    /// when using the
    /// [SubmitFeedback](https://docs.aws.amazon.com/kendra/latest/APIReference/API_SubmitFeedback.html)
    /// API.
    query_id: ?[]const u8 = null,

    /// The results of the search.
    result_items: ?[]const QueryResultItem = null,

    /// A list of information related to suggested spell corrections for a query.
    spell_corrected_queries: ?[]const SpellCorrectedQuery = null,

    /// The total number of items found by the search. However, you can only
    /// retrieve up to 100
    /// items. For example, if the search found 192 items, you can only retrieve the
    /// first 100 of
    /// the items.
    total_number_of_results: ?i32 = null,

    /// A list of warning codes and their messages on problems with your query.
    ///
    /// Amazon Kendra currently only supports one type of warning, which is a
    /// warning on
    /// invalid syntax used in the query. For examples of invalid query syntax, see
    /// [Searching
    /// with advanced query
    /// syntax](https://docs.aws.amazon.com/kendra/latest/dg/searching-example.html#searching-index-query-syntax).
    warnings: ?[]const Warning = null,

    pub const json_field_names = .{
        .facet_results = "FacetResults",
        .featured_results_items = "FeaturedResultsItems",
        .query_id = "QueryId",
        .result_items = "ResultItems",
        .spell_corrected_queries = "SpellCorrectedQueries",
        .total_number_of_results = "TotalNumberOfResults",
        .warnings = "Warnings",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: QueryInput, options: Options) !QueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kendra");

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

fn serializeRequest(alloc: std.mem.Allocator, input: QueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "AWSKendraFrontendService.Query");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !QueryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(QueryOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "FeaturedResultsConflictException")) {
        return .{ .arena = arena, .kind = .{ .featured_results_conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
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
