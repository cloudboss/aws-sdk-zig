const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InputConfig = @import("input_config.zig").InputConfig;
const OutputConfig = @import("output_config.zig").OutputConfig;
const StoppingCondition = @import("stopping_condition.zig").StoppingCondition;
const Tag = @import("tag.zig").Tag;
const NeoVpcConfig = @import("neo_vpc_config.zig").NeoVpcConfig;

pub const CreateCompilationJobInput = struct {
    /// A name for the model compilation job. The name must be unique within the
    /// Amazon Web Services Region and within your Amazon Web Services account.
    compilation_job_name: []const u8,

    /// Provides information about the location of input model artifacts, the name
    /// and shape of the expected data inputs, and the framework in which the model
    /// was trained.
    input_config: ?InputConfig = null,

    /// The Amazon Resource Name (ARN) of a versioned model package. Provide either
    /// a `ModelPackageVersionArn` or an `InputConfig` object in the request syntax.
    /// The presence of both objects in the `CreateCompilationJob` request will
    /// return an exception.
    model_package_version_arn: ?[]const u8 = null,

    /// Provides information about the output location for the compiled model and
    /// the target device the model runs on.
    output_config: OutputConfig,

    /// The Amazon Resource Name (ARN) of an IAM role that enables Amazon SageMaker
    /// AI to perform tasks on your behalf.
    ///
    /// During model compilation, Amazon SageMaker AI needs your permission to:
    ///
    /// * Read input data from an S3 bucket
    /// * Write model artifacts to an S3 bucket
    /// * Write logs to Amazon CloudWatch Logs
    /// * Publish metrics to Amazon CloudWatch
    ///
    /// You grant permissions for all of these tasks to an IAM role. To pass this
    /// role to Amazon SageMaker AI, the caller of this API must have the
    /// `iam:PassRole` permission. For more information, see [Amazon SageMaker AI
    /// Roles.](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-roles.html)
    role_arn: []const u8,

    /// Specifies a limit to how long a model compilation job can run. When the job
    /// reaches the time limit, Amazon SageMaker AI ends the compilation job. Use
    /// this API to cap model training costs.
    stopping_condition: StoppingCondition,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const Tag = null,

    /// A
    /// [VpcConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_VpcConfig.html) object that specifies the VPC that you want your compilation job to connect to. Control access to your models by configuring the VPC. For more information, see [Protect Compilation Jobs by Using an Amazon Virtual Private Cloud](https://docs.aws.amazon.com/sagemaker/latest/dg/neo-vpc.html).
    vpc_config: ?NeoVpcConfig = null,

    pub const json_field_names = .{
        .compilation_job_name = "CompilationJobName",
        .input_config = "InputConfig",
        .model_package_version_arn = "ModelPackageVersionArn",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .stopping_condition = "StoppingCondition",
        .tags = "Tags",
        .vpc_config = "VpcConfig",
    };
};

pub const CreateCompilationJobOutput = struct {
    /// If the action is successful, the service sends back an HTTP 200 response.
    /// Amazon SageMaker AI returns the following data in JSON format:
    ///
    /// * `CompilationJobArn`: The Amazon Resource Name (ARN) of the compiled job.
    compilation_job_arn: []const u8,

    pub const json_field_names = .{
        .compilation_job_arn = "CompilationJobArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCompilationJobInput, options: Options) !CreateCompilationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateCompilationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.CreateCompilationJob");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateCompilationJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateCompilationJobOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
