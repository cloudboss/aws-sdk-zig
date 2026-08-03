const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScheduledQueryInput, options: CallOptions) !CreateScheduledQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScheduledQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("query.timestream", "Timestream Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?errors.InternalServerException = aws.json.parseJsonObject(errors.InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEndpointException")) {
        const parsed_error: ?errors.InvalidEndpointException = aws.json.parseJsonObject(errors.InvalidEndpointException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_endpoint_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "QueryExecutionException")) {
        const parsed_error: ?errors.QueryExecutionException = aws.json.parseJsonObject(errors.QueryExecutionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .query_execution_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
