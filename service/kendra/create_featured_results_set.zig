const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FeaturedDocument = @import("featured_document.zig").FeaturedDocument;
const FeaturedResultsSetStatus = @import("featured_results_set_status.zig").FeaturedResultsSetStatus;
const Tag = @import("tag.zig").Tag;
const FeaturedResultsSet = @import("featured_results_set.zig").FeaturedResultsSet;

pub const CreateFeaturedResultsSetInput = struct {
    /// A token that you provide to identify the request to create a set of
    /// featured results. Multiple calls to the `CreateFeaturedResultsSet`
    /// API with the same client token will create only one featured results set.
    client_token: ?[]const u8 = null,

    /// A description for the set of featured results.
    description: ?[]const u8 = null,

    /// A list of document IDs for the documents you want to feature at the
    /// top of the search results page. For more information on the list of
    /// documents, see
    /// [FeaturedResultsSet](https://docs.aws.amazon.com/kendra/latest/dg/API_FeaturedResultsSet.html).
    featured_documents: ?[]const FeaturedDocument = null,

    /// A name for the set of featured results.
    featured_results_set_name: []const u8,

    /// The identifier of the index that you want to use for featuring results.
    index_id: []const u8,

    /// A list of queries for featuring results. For more information on the
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

    /// A list of key-value pairs that identify or categorize the featured results
    /// set. You
    /// can also use tags to help control access to the featured results set. Tag
    /// keys and
    /// values can consist of Unicode letters, digits, white space, and any of the
    /// following
    /// symbols:_ . : / = + - @.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .featured_documents = "FeaturedDocuments",
        .featured_results_set_name = "FeaturedResultsSetName",
        .index_id = "IndexId",
        .query_texts = "QueryTexts",
        .status = "Status",
        .tags = "Tags",
    };
};

pub const CreateFeaturedResultsSetOutput = struct {
    /// Information on the set of featured results. This includes the identifier of
    /// the featured results set, whether the featured results set is active or
    /// inactive,
    /// when the featured results set was created, and more.
    featured_results_set: ?FeaturedResultsSet = null,

    pub const json_field_names = .{
        .featured_results_set = "FeaturedResultsSet",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFeaturedResultsSetInput, options: Options) !CreateFeaturedResultsSetOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateFeaturedResultsSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AWSKendraFrontendService.CreateFeaturedResultsSet");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateFeaturedResultsSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFeaturedResultsSetOutput, body, alloc);
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
