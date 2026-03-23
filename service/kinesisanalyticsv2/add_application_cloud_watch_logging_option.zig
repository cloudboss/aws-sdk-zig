const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CloudWatchLoggingOption = @import("cloud_watch_logging_option.zig").CloudWatchLoggingOption;
const CloudWatchLoggingOptionDescription = @import("cloud_watch_logging_option_description.zig").CloudWatchLoggingOptionDescription;

pub const AddApplicationCloudWatchLoggingOptionInput = struct {
    /// The Kinesis Data Analytics application name.
    application_name: []const u8,

    /// Provides the Amazon CloudWatch log stream Amazon Resource Name (ARN).
    cloud_watch_logging_option: CloudWatchLoggingOption,

    /// A value you use to implement strong concurrency for application updates. You
    /// must
    /// provide the `CurrentApplicationVersionId` or the `ConditionalToken`. You
    /// get the application's current `ConditionalToken` using DescribeApplication.
    /// For better concurrency support, use the
    /// `ConditionalToken` parameter instead of
    /// `CurrentApplicationVersionId`.
    conditional_token: ?[]const u8 = null,

    /// The version ID of the SQL-based Kinesis Data Analytics application. You must
    /// provide the
    /// `CurrentApplicationVersionId` or the `ConditionalToken`.You can
    /// retrieve the application version ID using DescribeApplication. For better
    /// concurrency support, use the `ConditionalToken` parameter instead of
    /// `CurrentApplicationVersionId`.
    current_application_version_id: ?i64 = null,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .cloud_watch_logging_option = "CloudWatchLoggingOption",
        .conditional_token = "ConditionalToken",
        .current_application_version_id = "CurrentApplicationVersionId",
    };
};

pub const AddApplicationCloudWatchLoggingOptionOutput = struct {
    /// The application's ARN.
    application_arn: ?[]const u8 = null,

    /// The new version ID of the SQL-based Kinesis Data Analytics application.
    /// Kinesis Data Analytics
    /// updates the `ApplicationVersionId` each time you change the CloudWatch
    /// logging
    /// options.
    application_version_id: ?i64 = null,

    /// The descriptions of the current CloudWatch logging options for the SQL-based
    /// Kinesis Data Analytics application.
    cloud_watch_logging_option_descriptions: ?[]const CloudWatchLoggingOptionDescription = null,

    /// The operation ID that can be used to track the request.
    operation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationARN",
        .application_version_id = "ApplicationVersionId",
        .cloud_watch_logging_option_descriptions = "CloudWatchLoggingOptionDescriptions",
        .operation_id = "OperationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddApplicationCloudWatchLoggingOptionInput, options: CallOptions) !AddApplicationCloudWatchLoggingOptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kinesisanalytics");

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddApplicationCloudWatchLoggingOptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisanalytics", "Kinesis Analytics V2", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20180523.AddApplicationCloudWatchLoggingOption");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddApplicationCloudWatchLoggingOptionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AddApplicationCloudWatchLoggingOptionOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "CodeValidationException")) {
        return .{ .arena = arena, .kind = .{ .code_validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidApplicationConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_application_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceProvisionedThroughputExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_provisioned_throughput_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnableToDetectSchemaException")) {
        return .{ .arena = arena, .kind = .{ .unable_to_detect_schema_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
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
