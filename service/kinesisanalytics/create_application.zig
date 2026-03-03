const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CloudWatchLoggingOption = @import("cloud_watch_logging_option.zig").CloudWatchLoggingOption;
const Input = @import("input.zig").Input;
const Output = @import("output.zig").Output;
const Tag = @import("tag.zig").Tag;
const ApplicationSummary = @import("application_summary.zig").ApplicationSummary;

pub const CreateApplicationInput = struct {
    /// One or more SQL statements that read input data, transform it, and generate
    /// output.
    /// For example, you can write a SQL statement that reads data from one
    /// in-application
    /// stream, generates a running average of the number of advertisement clicks by
    /// vendor, and
    /// insert resulting rows in another in-application stream using pumps. For more
    /// information
    /// about the typical pattern, see [Application
    /// Code](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-it-works-app-code.html).
    ///
    /// You can provide such series of SQL statements,
    /// where output of one statement can be
    /// used as the input for the next statement. You store
    /// intermediate results by creating in-application streams and pumps.
    ///
    /// Note that the application code must create the streams with names
    /// specified in the `Outputs`. For example,
    /// if your `Outputs` defines output streams named
    /// `ExampleOutputStream1` and `ExampleOutputStream2`,
    /// then your application code must create these streams.
    application_code: ?[]const u8 = null,

    /// Summary description of the application.
    application_description: ?[]const u8 = null,

    /// Name of your Amazon Kinesis Analytics application (for example,
    /// `sample-app`).
    application_name: []const u8,

    /// Use this parameter to configure a CloudWatch log stream to monitor
    /// application
    /// configuration errors. For more information, see [Working with Amazon
    /// CloudWatch
    /// Logs](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/cloudwatch-logs.html).
    cloud_watch_logging_options: ?[]const CloudWatchLoggingOption = null,

    /// Use this parameter to configure the application input.
    ///
    /// You can configure your application to receive input from a single streaming
    /// source. In this configuration, you map this streaming source to an
    /// in-application stream that is created. Your application code can then query
    /// the in-application stream like a table (you can think of it as a constantly
    /// updating table).
    ///
    /// For the streaming source, you provide its Amazon Resource Name (ARN) and
    /// format of
    /// data on the stream (for example, JSON, CSV, etc.). You also must provide an
    /// IAM role
    /// that Amazon Kinesis Analytics can assume to read this stream on your behalf.
    ///
    /// To create the in-application stream, you need to specify a schema to
    /// transform your data into a schematized version used in SQL. In the schema,
    /// you provide the necessary mapping of the data elements in the streaming
    /// source to record columns in the in-app stream.
    inputs: ?[]const Input = null,

    /// You can configure application output to write data from any of the
    /// in-application streams to up to three destinations.
    ///
    /// These destinations can be Amazon Kinesis streams, Amazon Kinesis Firehose
    /// delivery
    /// streams, AWS Lambda destinations, or any combination of the three.
    ///
    /// In the configuration, you specify the in-application stream name, the
    /// destination stream or Lambda function Amazon Resource Name (ARN), and the
    /// format to use when writing data. You must also provide an IAM role that
    /// Amazon Kinesis Analytics can assume to write to the
    /// destination stream or Lambda function on your behalf.
    ///
    /// In the output configuration, you also provide the output stream or Lambda
    /// function ARN. For stream destinations, you provide the format
    /// of data in the stream (for example, JSON, CSV). You also must provide an IAM
    /// role that
    /// Amazon Kinesis Analytics can assume to write to the stream or Lambda
    /// function on your behalf.
    outputs: ?[]const Output = null,

    /// A list of one or more tags to assign to the application. A tag is a
    /// key-value pair that identifies an application. Note that the maximum number
    /// of application tags includes system tags. The maximum number of user-defined
    /// application tags is 50.
    /// For more information, see [Using
    /// Tagging](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-tagging.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .application_code = "ApplicationCode",
        .application_description = "ApplicationDescription",
        .application_name = "ApplicationName",
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .inputs = "Inputs",
        .outputs = "Outputs",
        .tags = "Tags",
    };
};

pub const CreateApplicationOutput = struct {
    /// In response to your `CreateApplication` request, Amazon Kinesis Analytics
    /// returns a
    /// response with a summary of the application it created, including the
    /// application Amazon Resource Name (ARN),
    /// name, and status.
    application_summary: ?ApplicationSummary = null,

    pub const json_field_names = .{
        .application_summary = "ApplicationSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationInput, options: CallOptions) !CreateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisanalytics", "Kinesis Analytics", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20150814.CreateApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateApplicationOutput, body, allocator);
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
