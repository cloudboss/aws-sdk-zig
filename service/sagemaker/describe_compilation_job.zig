const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CompilationJobStatus = @import("compilation_job_status.zig").CompilationJobStatus;
const DerivedInformation = @import("derived_information.zig").DerivedInformation;
const InputConfig = @import("input_config.zig").InputConfig;
const ModelArtifacts = @import("model_artifacts.zig").ModelArtifacts;
const ModelDigests = @import("model_digests.zig").ModelDigests;
const OutputConfig = @import("output_config.zig").OutputConfig;
const StoppingCondition = @import("stopping_condition.zig").StoppingCondition;
const NeoVpcConfig = @import("neo_vpc_config.zig").NeoVpcConfig;

pub const DescribeCompilationJobInput = struct {
    /// The name of the model compilation job that you want information about.
    compilation_job_name: []const u8,

    pub const json_field_names = .{
        .compilation_job_name = "CompilationJobName",
    };
};

pub const DescribeCompilationJobOutput = struct {
    /// The time when the model compilation job on a compilation job instance ended.
    /// For a successful or stopped job, this is when the job's model artifacts have
    /// finished uploading. For a failed job, this is when Amazon SageMaker AI
    /// detected that the job failed.
    compilation_end_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the model compilation job.
    compilation_job_arn: []const u8,

    /// The name of the model compilation job.
    compilation_job_name: []const u8,

    /// The status of the model compilation job.
    compilation_job_status: CompilationJobStatus,

    /// The time when the model compilation job started the `CompilationJob`
    /// instances.
    ///
    /// You are billed for the time between this timestamp and the timestamp in the
    /// `CompilationEndTime` field. In Amazon CloudWatch Logs, the start time might
    /// be later than this time. That's because it takes time to download the
    /// compilation job, which depends on the size of the compilation job container.
    compilation_start_time: ?i64 = null,

    /// The time that the model compilation job was created.
    creation_time: i64,

    /// Information that SageMaker Neo automatically derived about the model.
    derived_information: ?DerivedInformation = null,

    /// If a model compilation job failed, the reason it failed.
    failure_reason: []const u8,

    /// The inference image to use when compiling a model. Specify an image only if
    /// the target device is a cloud instance.
    inference_image: ?[]const u8 = null,

    /// Information about the location in Amazon S3 of the input model artifacts,
    /// the name and shape of the expected data inputs, and the framework in which
    /// the model was trained.
    input_config: ?InputConfig = null,

    /// The time that the status of the model compilation job was last modified.
    last_modified_time: i64,

    /// Information about the location in Amazon S3 that has been configured for
    /// storing the model artifacts used in the compilation job.
    model_artifacts: ?ModelArtifacts = null,

    /// Provides a BLAKE2 hash value that identifies the compiled model artifacts in
    /// Amazon S3.
    model_digests: ?ModelDigests = null,

    /// The Amazon Resource Name (ARN) of the versioned model package that was
    /// provided to SageMaker Neo when you initiated a compilation job.
    model_package_version_arn: ?[]const u8 = null,

    /// Information about the output location for the compiled model and the target
    /// device that the model runs on.
    output_config: ?OutputConfig = null,

    /// The Amazon Resource Name (ARN) of an IAM role that Amazon SageMaker AI
    /// assumes to perform the model compilation job.
    role_arn: []const u8,

    /// Specifies a limit to how long a model compilation job can run. When the job
    /// reaches the time limit, Amazon SageMaker AI ends the compilation job. Use
    /// this API to cap model training costs.
    stopping_condition: ?StoppingCondition = null,

    /// A
    /// [VpcConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_VpcConfig.html) object that specifies the VPC that you want your compilation job to connect to. Control access to your models by configuring the VPC. For more information, see [Protect Compilation Jobs by Using an Amazon Virtual Private Cloud](https://docs.aws.amazon.com/sagemaker/latest/dg/neo-vpc.html).
    vpc_config: ?NeoVpcConfig = null,

    pub const json_field_names = .{
        .compilation_end_time = "CompilationEndTime",
        .compilation_job_arn = "CompilationJobArn",
        .compilation_job_name = "CompilationJobName",
        .compilation_job_status = "CompilationJobStatus",
        .compilation_start_time = "CompilationStartTime",
        .creation_time = "CreationTime",
        .derived_information = "DerivedInformation",
        .failure_reason = "FailureReason",
        .inference_image = "InferenceImage",
        .input_config = "InputConfig",
        .last_modified_time = "LastModifiedTime",
        .model_artifacts = "ModelArtifacts",
        .model_digests = "ModelDigests",
        .model_package_version_arn = "ModelPackageVersionArn",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .stopping_condition = "StoppingCondition",
        .vpc_config = "VpcConfig",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCompilationJobInput, options: Options) !DescribeCompilationJobOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeCompilationJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.DescribeCompilationJob");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeCompilationJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCompilationJobOutput, body, alloc);
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
