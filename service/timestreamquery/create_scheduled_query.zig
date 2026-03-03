const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ErrorReportConfiguration = @import("error_report_configuration.zig").ErrorReportConfiguration;
const NotificationConfiguration = @import("notification_configuration.zig").NotificationConfiguration;
const ScheduleConfiguration = @import("schedule_configuration.zig").ScheduleConfiguration;
const Tag = @import("tag.zig").Tag;
const TargetConfiguration = @import("target_configuration.zig").TargetConfiguration;

pub const CreateScheduledQueryInput = struct {
    /// Using a ClientToken makes the call to CreateScheduledQuery idempotent, in
    /// other words,
    /// making the same request repeatedly will produce the same result. Making
    /// multiple
    /// identical CreateScheduledQuery requests has the same effect as making a
    /// single request.
    ///
    /// * If CreateScheduledQuery is called without a `ClientToken`, the
    /// Query SDK generates a `ClientToken` on your behalf.
    ///
    /// * After 8 hours, any request with the same `ClientToken` is treated
    /// as a new request.
    client_token: ?[]const u8 = null,

    /// Configuration for error reporting. Error reports will be generated when a
    /// problem is
    /// encountered when writing the query results.
    error_report_configuration: ErrorReportConfiguration,

    /// The Amazon KMS key used to encrypt the scheduled query resource, at-rest. If
    /// the
    /// Amazon KMS key is not specified, the scheduled query resource will be
    /// encrypted with a
    /// Timestream owned Amazon KMS key. To specify a KMS key, use the key ID, key
    /// ARN, alias
    /// name, or alias ARN. When using an alias name, prefix the name with
    /// *alias/*
    ///
    /// If ErrorReportConfiguration uses `SSE_KMS` as encryption type, the same
    /// KmsKeyId is used to encrypt the error report at rest.
    kms_key_id: ?[]const u8 = null,

    /// Name of the scheduled query.
    name: []const u8,

    /// Notification configuration for the scheduled query. A notification is sent
    /// by
    /// Timestream when a query run finishes, when the state is updated or when you
    /// delete it.
    notification_configuration: NotificationConfiguration,

    /// The query string to run. Parameter names can be specified in the query
    /// string
    /// `@` character followed by an identifier. The named Parameter
    /// `@scheduled_runtime` is reserved and can be used in the query to get the
    /// time at which the query is scheduled to run.
    ///
    /// The timestamp calculated according to the ScheduleConfiguration parameter,
    /// will be the
    /// value of `@scheduled_runtime` paramater for each query run. For example,
    /// consider an instance of a scheduled query executing on 2021-12-01 00:00:00.
    /// For this
    /// instance, the `@scheduled_runtime` parameter is initialized to the timestamp
    /// 2021-12-01 00:00:00 when invoking the query.
    query_string: []const u8,

    /// The schedule configuration for the query.
    schedule_configuration: ScheduleConfiguration,

    /// The ARN for the IAM role that Timestream will assume when running the
    /// scheduled query.
    scheduled_query_execution_role_arn: []const u8,

    /// A list of key-value pairs to label the scheduled query.
    tags: ?[]const Tag = null,

    /// Configuration used for writing the result of a query.
    target_configuration: ?TargetConfiguration = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .error_report_configuration = "ErrorReportConfiguration",
        .kms_key_id = "KmsKeyId",
        .name = "Name",
        .notification_configuration = "NotificationConfiguration",
        .query_string = "QueryString",
        .schedule_configuration = "ScheduleConfiguration",
        .scheduled_query_execution_role_arn = "ScheduledQueryExecutionRoleArn",
        .tags = "Tags",
        .target_configuration = "TargetConfiguration",
    };
};

pub const CreateScheduledQueryOutput = struct {
    /// ARN for the created scheduled query.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScheduledQueryInput, options: Options) !CreateScheduledQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "timestreamquery");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScheduledQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("timestreamquery", "Timestream Query", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.CreateScheduledQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateScheduledQueryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateScheduledQueryOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InvalidEndpointException")) {
        return .{ .arena = arena, .kind = .{ .invalid_endpoint_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryExecutionException")) {
        return .{ .arena = arena, .kind = .{ .query_execution_exception = .{
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
