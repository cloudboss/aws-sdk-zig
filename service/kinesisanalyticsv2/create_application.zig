const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ApplicationConfiguration = @import("application_configuration.zig").ApplicationConfiguration;
const ApplicationMode = @import("application_mode.zig").ApplicationMode;
const CloudWatchLoggingOption = @import("cloud_watch_logging_option.zig").CloudWatchLoggingOption;
const RuntimeEnvironment = @import("runtime_environment.zig").RuntimeEnvironment;
const Tag = @import("tag.zig").Tag;
const ApplicationDetail = @import("application_detail.zig").ApplicationDetail;

pub const CreateApplicationInput = struct {
    /// Use this parameter to configure the application.
    application_configuration: ?ApplicationConfiguration = null,

    /// A summary description of the application.
    application_description: ?[]const u8 = null,

    /// Use the `STREAMING` mode to create a Managed Service for Apache Flink
    /// application. To create a Managed Service for Apache Flink Studio notebook,
    /// use the
    /// `INTERACTIVE` mode.
    application_mode: ?ApplicationMode = null,

    /// The name of your application (for example, `sample-app`).
    application_name: []const u8,

    /// Use this parameter to configure an Amazon CloudWatch log stream to monitor
    /// application
    /// configuration errors.
    cloud_watch_logging_options: ?[]const CloudWatchLoggingOption = null,

    /// The runtime environment for the application.
    runtime_environment: RuntimeEnvironment,

    /// The IAM role used by the application to access Kinesis data streams, Kinesis
    /// Data Firehose
    /// delivery streams, Amazon S3 objects, and other external resources.
    service_execution_role: []const u8,

    /// A list of one or more tags to assign to the application. A tag is a
    /// key-value pair that identifies an
    /// application. Note that the maximum number of application tags includes
    /// system tags. The maximum number of
    /// user-defined application tags is 50.
    /// For more information, see
    /// [Using
    /// Tagging](https://docs.aws.amazon.com/kinesisanalytics/latest/java/how-tagging.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .application_configuration = "ApplicationConfiguration",
        .application_description = "ApplicationDescription",
        .application_mode = "ApplicationMode",
        .application_name = "ApplicationName",
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .runtime_environment = "RuntimeEnvironment",
        .service_execution_role = "ServiceExecutionRole",
        .tags = "Tags",
    };
};

pub const CreateApplicationOutput = struct {
    /// In response to your `CreateApplication` request, Managed Service for Apache
    /// Flink returns a
    /// response with details of the application it created.
    application_detail: ?ApplicationDetail = null,

    pub const json_field_names = .{
        .application_detail = "ApplicationDetail",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationInput, options: Options) !CreateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kinesisanalyticsv2");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisanalyticsv2", "Kinesis Analytics V2", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "KinesisAnalytics_20180523.CreateApplication");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateApplicationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateApplicationOutput, body, alloc);
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
