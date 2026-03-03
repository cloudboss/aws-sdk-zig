const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DataSourceFilter = @import("data_source_filter.zig").DataSourceFilter;
const LogGroupClass = @import("log_group_class.zig").LogGroupClass;
const LogGroupSummary = @import("log_group_summary.zig").LogGroupSummary;

pub const ListLogGroupsInput = struct {
    /// When `includeLinkedAccounts` is set to `true`, use this parameter to
    /// specify the list of accounts to search. You can specify as many as 20
    /// account IDs in the
    /// array.
    account_identifiers: ?[]const []const u8 = null,

    /// An array of data source filters to filter log groups by their associated
    /// data sources. You
    /// can filter by data source name, type, or both. Multiple filters within the
    /// same dimension are
    /// combined with OR logic, while filters across different dimensions are
    /// combined with AND
    /// logic.
    data_sources: ?[]const DataSourceFilter = null,

    /// An array of field index names to filter log groups that have specific field
    /// indexes. Only
    /// log groups containing all specified field indexes are returned. You can
    /// specify 1 to 20 field
    /// index names, each with 1 to 512 characters.
    field_index_names: ?[]const []const u8 = null,

    /// If you are using a monitoring account, set this to `true` to have the
    /// operation
    /// return log groups in the accounts listed in `accountIdentifiers`.
    ///
    /// If this parameter is set to `true` and `accountIdentifiers` contains
    /// a null value, the operation returns all log groups in the monitoring account
    /// and all log
    /// groups in all source accounts that are linked to the monitoring account.
    ///
    /// The default for this parameter is `false`.
    include_linked_accounts: ?bool = null,

    /// The maximum number of log groups to return. If you omit this parameter, the
    /// default is
    /// up to 50 log groups.
    limit: ?i32 = null,

    /// Use this parameter to limit the results to only those log groups in the
    /// specified log
    /// group class. If you omit this parameter, log groups of all classes can be
    /// returned.
    log_group_class: ?LogGroupClass = null,

    /// Use this parameter to limit the returned log groups to only those with names
    /// that match
    /// the pattern that you specify. This parameter is a regular expression that
    /// can match prefixes
    /// and substrings, and supports wildcard matching and matching multiple
    /// patterns, as in the
    /// following examples.
    ///
    /// * Use `^` to match log group names by prefix.
    ///
    /// * For a substring match, specify the string to match. All matches are case
    /// sensitive
    ///
    /// * To match multiple patterns, separate them with a `|` as in the example
    /// `^/aws/lambda|discovery`
    ///
    /// You can specify as many as five different regular expression patterns in
    /// this field, each
    /// of which must be between 3 and 24 characters. You can include the `^` symbol
    /// as
    /// many as five times, and include the `|` symbol as many as four times.
    log_group_name_pattern: ?[]const u8 = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_identifiers = "accountIdentifiers",
        .data_sources = "dataSources",
        .field_index_names = "fieldIndexNames",
        .include_linked_accounts = "includeLinkedAccounts",
        .limit = "limit",
        .log_group_class = "logGroupClass",
        .log_group_name_pattern = "logGroupNamePattern",
        .next_token = "nextToken",
    };
};

pub const ListLogGroupsOutput = struct {
    /// An array of structures, where each structure contains the information about
    /// one log
    /// group.
    log_groups: ?[]const LogGroupSummary = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_groups = "logGroups",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLogGroupsInput, options: CallOptions) !ListLogGroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudwatchlogs");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLogGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudwatchlogs", "CloudWatch Logs", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.ListLogGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLogGroupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListLogGroupsOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "DataAlreadyAcceptedException")) {
        return .{ .arena = arena, .kind = .{ .data_already_accepted_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSequenceTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sequence_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedQueryException")) {
        return .{ .arena = arena, .kind = .{ .malformed_query_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationAbortedException")) {
        return .{ .arena = arena, .kind = .{ .operation_aborted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnrecognizedClientException")) {
        return .{ .arena = arena, .kind = .{ .unrecognized_client_exception = .{
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
