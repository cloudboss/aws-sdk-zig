const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const LogGroupClass = @import("log_group_class.zig").LogGroupClass;
const LogGroup = @import("log_group.zig").LogGroup;

pub const DescribeLogGroupsInput = struct {
    /// When `includeLinkedAccounts` is set to `true`, use this parameter to
    /// specify the list of accounts to search. You can specify as many as 20
    /// account IDs in the
    /// array.
    account_identifiers: ?[]const []const u8 = null,

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

    /// The maximum number of items returned. If you don't specify a value, the
    /// default is up
    /// to 50 items.
    limit: ?i32 = null,

    /// Use this parameter to limit the results to only those log groups in the
    /// specified log
    /// group class. If you omit this parameter, log groups of all classes can be
    /// returned.
    ///
    /// Specifies the log group class for this log group. There are three classes:
    ///
    /// * The `Standard` log class supports all CloudWatch Logs features.
    ///
    /// * The `Infrequent Access` log class supports a subset of CloudWatch Logs
    /// features and incurs lower costs.
    ///
    /// * Use the `Delivery` log class only for delivering Lambda
    /// logs to store in Amazon S3 or Amazon Data Firehose. Log events in log groups
    /// in
    /// the Delivery class are kept in CloudWatch Logs for only one day. This log
    /// class doesn't
    /// offer rich CloudWatch Logs capabilities such as CloudWatch Logs Insights
    /// queries.
    ///
    /// For details about the features supported by each class, see [Log
    /// classes](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch_Logs_Log_Classes.html)
    log_group_class: ?LogGroupClass = null,

    /// Use this array to filter the list of log groups returned. If you specify
    /// this parameter,
    /// the only other filter that you can choose to specify is
    /// `includeLinkedAccounts`.
    ///
    /// If you are using this operation in a monitoring account, you can specify the
    /// ARNs of log
    /// groups in source accounts and in the monitoring account itself. If you are
    /// using this
    /// operation in an account that is not a cross-account monitoring account, you
    /// can specify only
    /// log group names in the same account as the operation.
    log_group_identifiers: ?[]const []const u8 = null,

    /// If you specify a string for this parameter, the operation returns only log
    /// groups that
    /// have names that match the string based on a case-sensitive substring search.
    /// For example, if
    /// you specify `DataLogs`, log groups named `DataLogs`,
    /// `aws/DataLogs`, and `GroupDataLogs` would match, but
    /// `datalogs`, `Data/log/s` and `Groupdata` would not
    /// match.
    ///
    /// If you specify `logGroupNamePattern` in your request, then only
    /// `arn`, `creationTime`, and `logGroupName` are included in
    /// the response.
    ///
    /// `logGroupNamePattern` and `logGroupNamePrefix` are mutually exclusive.
    /// Only one of these parameters can be passed.
    log_group_name_pattern: ?[]const u8 = null,

    /// The prefix to match.
    ///
    /// `logGroupNamePrefix` and `logGroupNamePattern` are mutually exclusive.
    /// Only one of these parameters can be passed.
    log_group_name_prefix: ?[]const u8 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_identifiers = "accountIdentifiers",
        .include_linked_accounts = "includeLinkedAccounts",
        .limit = "limit",
        .log_group_class = "logGroupClass",
        .log_group_identifiers = "logGroupIdentifiers",
        .log_group_name_pattern = "logGroupNamePattern",
        .log_group_name_prefix = "logGroupNamePrefix",
        .next_token = "nextToken",
    };
};

pub const DescribeLogGroupsOutput = struct {
    /// An array of structures, where each structure contains the information about
    /// one log
    /// group.
    log_groups: ?[]const LogGroup = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_groups = "logGroups",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLogGroupsInput, options: CallOptions) !DescribeLogGroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "logs");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLogGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.DescribeLogGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLogGroupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLogGroupsOutput, body, allocator);
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
