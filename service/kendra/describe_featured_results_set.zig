const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FeaturedDocumentMissing = @import("featured_document_missing.zig").FeaturedDocumentMissing;
const FeaturedDocumentWithMetadata = @import("featured_document_with_metadata.zig").FeaturedDocumentWithMetadata;
const FeaturedResultsSetStatus = @import("featured_results_set_status.zig").FeaturedResultsSetStatus;

pub const DescribeFeaturedResultsSetInput = struct {
    /// The identifier of the set of featured results that you want to get
    /// information on.
    featured_results_set_id: []const u8,

    /// The identifier of the index used for featuring results.
    index_id: []const u8,

    pub const json_field_names = .{
        .featured_results_set_id = "FeaturedResultsSetId",
        .index_id = "IndexId",
    };
};

pub const DescribeFeaturedResultsSetOutput = struct {
    /// The Unix timestamp when the set of the featured results was created.
    creation_timestamp: ?i64 = null,

    /// The description for the set of featured results.
    description: ?[]const u8 = null,

    /// The list of document IDs that don't exist but you have specified as featured
    /// documents. Amazon Kendra cannot feature these documents if they don't exist
    /// in the index. You can check the status of a document and its ID or check for
    /// documents with status errors using the
    /// [BatchGetDocumentStatus](https://docs.aws.amazon.com/kendra/latest/dg/API_BatchGetDocumentStatus.html) API.
    featured_documents_missing: ?[]const FeaturedDocumentMissing = null,

    /// The list of document IDs for the documents you want to feature with their
    /// metadata information. For more information on the list of featured
    /// documents,
    /// see
    /// [FeaturedResultsSet](https://docs.aws.amazon.com/kendra/latest/dg/API_FeaturedResultsSet.html).
    featured_documents_with_metadata: ?[]const FeaturedDocumentWithMetadata = null,

    /// The identifier of the set of featured results.
    featured_results_set_id: ?[]const u8 = null,

    /// The name for the set of featured results.
    featured_results_set_name: ?[]const u8 = null,

    /// The timestamp when the set of featured results was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The list of queries for featuring results. For more information on the
    /// list of queries, see
    /// [FeaturedResultsSet](https://docs.aws.amazon.com/kendra/latest/dg/API_FeaturedResultsSet.html).
    query_texts: ?[]const []const u8 = null,

    /// The current status of the set of featured results. When the value is
    /// `ACTIVE`, featured results are ready for use. You can still
    /// configure your settings before setting the status to `ACTIVE`.
    /// You can set the status to `ACTIVE` or `INACTIVE`
    /// using the
    /// [UpdateFeaturedResultsSet](https://docs.aws.amazon.com/kendra/latest/dg/API_UpdateFeaturedResultsSet.html) API. The queries you specify for
    /// featured results must be unique per featured results set for each index,
    /// whether the status is `ACTIVE` or `INACTIVE`.
    status: ?FeaturedResultsSetStatus = null,

    pub const json_field_names = .{
        .creation_timestamp = "CreationTimestamp",
        .description = "Description",
        .featured_documents_missing = "FeaturedDocumentsMissing",
        .featured_documents_with_metadata = "FeaturedDocumentsWithMetadata",
        .featured_results_set_id = "FeaturedResultsSetId",
        .featured_results_set_name = "FeaturedResultsSetName",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .query_texts = "QueryTexts",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFeaturedResultsSetInput, options: CallOptions) !DescribeFeaturedResultsSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFeaturedResultsSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.DescribeFeaturedResultsSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFeaturedResultsSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFeaturedResultsSetOutput, body, allocator);
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
