const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ParameterDefinition = @import("parameter_definition.zig").ParameterDefinition;
const Capability = @import("capability.zig").Capability;

pub const CreateApplicationVersionInput = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_id: []const u8,

    /// The semantic version of the new version.
    semantic_version: []const u8,

    /// A link to the S3 object that contains the ZIP archive of the source code for
    /// this version of your application.
    ///
    /// Maximum size 50 MB
    source_code_archive_url: ?[]const u8 = null,

    /// A link to a public repository for the source code of your application, for
    /// example the URL of a specific GitHub commit.
    source_code_url: ?[]const u8 = null,

    /// The raw packaged AWS SAM template of your application.
    template_body: ?[]const u8 = null,

    /// A link to the packaged AWS SAM template of your application.
    template_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .semantic_version = "SemanticVersion",
        .source_code_archive_url = "SourceCodeArchiveUrl",
        .source_code_url = "SourceCodeUrl",
        .template_body = "TemplateBody",
        .template_url = "TemplateUrl",
    };
};

pub const CreateApplicationVersionOutput = struct {
    /// The application Amazon Resource Name (ARN).
    application_id: ?[]const u8 = null,

    /// The date and time this resource was created.
    creation_time: ?[]const u8 = null,

    /// An array of parameter types supported by the application.
    parameter_definitions: ?[]const ParameterDefinition = null,

    /// A list of values that you must specify before you can deploy certain
    /// applications.
    /// Some applications might include resources that can affect permissions in
    /// your AWS
    /// account, for example, by creating new AWS Identity and Access Management
    /// (IAM) users.
    /// For those applications, you must explicitly acknowledge their capabilities
    /// by
    /// specifying this parameter.
    ///
    /// The only valid values are CAPABILITY_IAM, CAPABILITY_NAMED_IAM,
    /// CAPABILITY_RESOURCE_POLICY, and CAPABILITY_AUTO_EXPAND.
    ///
    /// The following resources require you to specify CAPABILITY_IAM or
    /// CAPABILITY_NAMED_IAM:
    /// [AWS::IAM::Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-group.html),
    /// [AWS::IAM::InstanceProfile](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html),
    /// [AWS::IAM::Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-policy.html), and
    /// [AWS::IAM::Role](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html).
    /// If the application contains IAM resources, you can specify either
    /// CAPABILITY_IAM
    /// or CAPABILITY_NAMED_IAM. If the application contains IAM resources
    /// with custom names, you must specify CAPABILITY_NAMED_IAM.
    ///
    /// The following resources require you to specify CAPABILITY_RESOURCE_POLICY:
    /// [AWS::Lambda::Permission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-permission.html),
    /// [AWS::IAM:Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-policy.html),
    /// [AWS::ApplicationAutoScaling::ScalingPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-applicationautoscaling-scalingpolicy.html),
    /// [AWS::S3::BucketPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-policy.html),
    /// [AWS::SQS::QueuePolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sqs-policy.html), and
    /// [AWS::SNS::TopicPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sns-policy.html).
    ///
    /// Applications that contain one or more nested applications require you to
    /// specify
    /// CAPABILITY_AUTO_EXPAND.
    ///
    /// If your application template contains any of the above resources, we
    /// recommend that you review
    /// all permissions associated with the application before deploying. If you
    /// don't specify
    /// this parameter for an application that requires capabilities, the call will
    /// fail.
    required_capabilities: ?[]const Capability = null,

    /// Whether all of the AWS resources contained in this application are supported
    /// in the region
    /// in which it is being retrieved.
    resources_supported: ?bool = null,

    /// The semantic version of the application:
    ///
    /// [https://semver.org/](https://semver.org/)
    semantic_version: ?[]const u8 = null,

    /// A link to the S3 object that contains the ZIP archive of the source code for
    /// this version of your application.
    ///
    /// Maximum size 50 MB
    source_code_archive_url: ?[]const u8 = null,

    /// A link to a public repository for the source code of your application, for
    /// example the URL of a specific GitHub commit.
    source_code_url: ?[]const u8 = null,

    /// A link to the packaged AWS SAM template of your application.
    template_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .creation_time = "CreationTime",
        .parameter_definitions = "ParameterDefinitions",
        .required_capabilities = "RequiredCapabilities",
        .resources_supported = "ResourcesSupported",
        .semantic_version = "SemanticVersion",
        .source_code_archive_url = "SourceCodeArchiveUrl",
        .source_code_url = "SourceCodeUrl",
        .template_url = "TemplateUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationVersionInput, options: CallOptions) !CreateApplicationVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "serverlessrepo");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("serverlessrepo", "ServerlessApplicationRepository", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.semantic_version);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.source_code_archive_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceCodeArchiveUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_code_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceCodeUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.template_body) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TemplateBody\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.template_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TemplateUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationVersionOutput {
    var result: CreateApplicationVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateApplicationVersionOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
