const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeFilter = @import("attribute_filter.zig").AttributeFilter;
const DocumentRelevanceConfiguration = @import("document_relevance_configuration.zig").DocumentRelevanceConfiguration;
const UserContext = @import("user_context.zig").UserContext;
const RetrieveResultItem = @import("retrieve_result_item.zig").RetrieveResultItem;

pub const RetrieveInput = struct {
    /// Filters search results by document fields/attributes. You can only provide
    /// one
    /// attribute filter; however, the `AndAllFilters`, `NotFilter`, and
    /// `OrAllFilters` parameters contain a list of other filters.
    ///
    /// The `AttributeFilter` parameter means you can create a set of filtering
    /// rules that a document must satisfy to be included in the query results.
    ///
    /// For Amazon Kendra Gen AI Enterprise Edition indices use `AttributeFilter` to
    /// enable document filtering for end users using `_email_id` or include
    /// public documents (`_email_id=null`).
    attribute_filter: ?AttributeFilter = null,

    /// Overrides relevance tuning configurations of fields/attributes set at the
    /// index
    /// level.
    ///
    /// If you use this API to override the relevance tuning configured at the index
    /// level,
    /// but there is no relevance tuning configured at the index level, then Amazon
    /// Kendra
    /// does not apply any relevance tuning.
    ///
    /// If there is relevance tuning configured for fields at the index level, and
    /// you use
    /// this API to override only some of these fields, then for the fields you did
    /// not
    /// override, the importance is set to 1.
    document_relevance_override_configurations: ?[]const DocumentRelevanceConfiguration = null,

    /// The identifier of the index to retrieve relevant passages for the search.
    index_id: []const u8,

    /// Retrieved relevant passages are returned in pages the size of the
    /// `PageSize` parameter. By default, Amazon Kendra returns the first
    /// page of results. Use this parameter to get result pages after the first one.
    page_number: ?i32 = null,

    /// Sets the number of retrieved relevant passages that are returned in each
    /// page of
    /// results. The default page size is 10. The maximum number of results returned
    /// is 100. If
    /// you ask for more than 100 results, only 100 are returned.
    page_size: ?i32 = null,

    /// The input query text to retrieve relevant passages for the search. Amazon
    /// Kendra
    /// truncates queries at 30 token words, which excludes punctuation and stop
    /// words.
    /// Truncation still applies if you use Boolean or more advanced, complex
    /// queries. For
    /// example, `Timeoff AND October AND Category:HR` is counted as 3 tokens:
    /// `timeoff`, `october`, `hr`. For more information,
    /// see [Searching with advanced query
    /// syntax](https://docs.aws.amazon.com/kendra/latest/dg/searching-example.html#searching-index-query-syntax) in the Amazon Kendra Developer Guide.
    query_text: []const u8,

    /// A list of document fields/attributes to include in the response. You can
    /// limit the
    /// response to include certain document fields. By default, all document fields
    /// are
    /// included in the response.
    requested_document_attributes: ?[]const []const u8 = null,

    /// The user context token or user and group information.
    user_context: ?UserContext = null,

    pub const json_field_names = .{
        .attribute_filter = "AttributeFilter",
        .document_relevance_override_configurations = "DocumentRelevanceOverrideConfigurations",
        .index_id = "IndexId",
        .page_number = "PageNumber",
        .page_size = "PageSize",
        .query_text = "QueryText",
        .requested_document_attributes = "RequestedDocumentAttributes",
        .user_context = "UserContext",
    };
};

pub const RetrieveOutput = struct {
    /// The identifier of query used for the search. You also use `QueryId` to
    /// identify the search when using the
    /// [Submitfeedback](https://docs.aws.amazon.com/kendra/latest/APIReference/API_SubmitFeedback.html)
    /// API.
    query_id: ?[]const u8 = null,

    /// The results of the retrieved relevant passages for the search.
    result_items: ?[]const RetrieveResultItem = null,

    pub const json_field_names = .{
        .query_id = "QueryId",
        .result_items = "ResultItems",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetrieveInput, options: Options) !RetrieveOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RetrieveInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.Retrieve");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RetrieveOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RetrieveOutput, body, allocator);
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
