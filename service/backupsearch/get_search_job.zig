const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CurrentSearchProgress = @import("current_search_progress.zig").CurrentSearchProgress;
const ItemFilters = @import("item_filters.zig").ItemFilters;
const SearchScope = @import("search_scope.zig").SearchScope;
const SearchScopeSummary = @import("search_scope_summary.zig").SearchScopeSummary;
const SearchJobState = @import("search_job_state.zig").SearchJobState;

pub const GetSearchJobInput = struct {
    /// Required unique string that specifies the search job.
    search_job_identifier: []const u8,

    pub const json_field_names = .{
        .search_job_identifier = "SearchJobIdentifier",
    };
};

pub const GetSearchJobOutput = struct {
    /// The date and time that a search job completed, in Unix format and
    /// Coordinated Universal Time (UTC). The value of `CompletionTime` is accurate
    /// to milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018 12:11:30.087 AM.
    completion_time: ?i64 = null,

    /// The date and time that a search job was created, in Unix format and
    /// Coordinated Universal Time (UTC). The value of `CompletionTime` is accurate
    /// to milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018 12:11:30.087 AM.
    creation_time: i64,

    /// Returns numbers representing BackupsScannedCount, ItemsScanned, and
    /// ItemsMatched.
    current_search_progress: ?CurrentSearchProgress = null,

    /// The encryption key for the specified search job.
    ///
    /// Example:
    /// `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    encryption_key_arn: ?[]const u8 = null,

    /// Item Filters represent all input item properties specified when the search
    /// was created.
    item_filters: ?ItemFilters = null,

    /// Returned name of the specified search job.
    name: ?[]const u8 = null,

    /// The unique string that identifies the Amazon Resource Name (ARN) of the
    /// specified search job.
    search_job_arn: []const u8,

    /// The unique string that identifies the specified search job.
    search_job_identifier: []const u8,

    /// The search scope is all backup properties input into a search.
    search_scope: ?SearchScope = null,

    /// Returned summary of the specified search job scope, including:
    ///
    /// * TotalBackupsToScanCount, the number of recovery points returned by the
    ///   search.
    /// * TotalItemsToScanCount, the number of items returned by the search.
    search_scope_summary: ?SearchScopeSummary = null,

    /// The current status of the specified search job.
    ///
    /// A search job may have one of the following statuses: `RUNNING`; `COMPLETED`;
    /// `STOPPED`; `FAILED`; `TIMED_OUT`; or `EXPIRED` .
    status: SearchJobState,

    /// A status message will be returned for either a earch job with a status of
    /// `ERRORED` or a status of `COMPLETED` jobs with issues.
    ///
    /// For example, a message may say that a search contained recovery points
    /// unable to be scanned because of a permissions issue.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .current_search_progress = "CurrentSearchProgress",
        .encryption_key_arn = "EncryptionKeyArn",
        .item_filters = "ItemFilters",
        .name = "Name",
        .search_job_arn = "SearchJobArn",
        .search_job_identifier = "SearchJobIdentifier",
        .search_scope = "SearchScope",
        .search_scope_summary = "SearchScopeSummary",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSearchJobInput, options: CallOptions) !GetSearchJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "backup-search");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSearchJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup-search", "BackupSearch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/search-jobs/");
    try path_buf.appendSlice(allocator, input.search_job_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSearchJobOutput {
    var result: GetSearchJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSearchJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
