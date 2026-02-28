const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Architecture = @import("architecture.zig").Architecture;
const CapacityProviderConfig = @import("capacity_provider_config.zig").CapacityProviderConfig;
const FunctionCode = @import("function_code.zig").FunctionCode;
const DeadLetterConfig = @import("dead_letter_config.zig").DeadLetterConfig;
const DurableConfig = @import("durable_config.zig").DurableConfig;
const Environment = @import("environment.zig").Environment;
const EphemeralStorage = @import("ephemeral_storage.zig").EphemeralStorage;
const FileSystemConfig = @import("file_system_config.zig").FileSystemConfig;
const ImageConfig = @import("image_config.zig").ImageConfig;
const LoggingConfig = @import("logging_config.zig").LoggingConfig;
const PackageType = @import("package_type.zig").PackageType;
const FunctionVersionLatestPublished = @import("function_version_latest_published.zig").FunctionVersionLatestPublished;
const Runtime = @import("runtime.zig").Runtime;
const SnapStart = @import("snap_start.zig").SnapStart;
const TenancyConfig = @import("tenancy_config.zig").TenancyConfig;
const TracingConfig = @import("tracing_config.zig").TracingConfig;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const EnvironmentResponse = @import("environment_response.zig").EnvironmentResponse;
const ImageConfigResponse = @import("image_config_response.zig").ImageConfigResponse;
const LastUpdateStatus = @import("last_update_status.zig").LastUpdateStatus;
const LastUpdateStatusReasonCode = @import("last_update_status_reason_code.zig").LastUpdateStatusReasonCode;
const Layer = @import("layer.zig").Layer;
const RuntimeVersionConfig = @import("runtime_version_config.zig").RuntimeVersionConfig;
const SnapStartResponse = @import("snap_start_response.zig").SnapStartResponse;
const State = @import("state.zig").State;
const StateReasonCode = @import("state_reason_code.zig").StateReasonCode;
const TracingConfigResponse = @import("tracing_config_response.zig").TracingConfigResponse;
const VpcConfigResponse = @import("vpc_config_response.zig").VpcConfigResponse;

pub const CreateFunctionInput = struct {
    /// The instruction set architecture that the function supports. Enter a string
    /// array with one of the valid values (arm64 or x86_64). The default value is
    /// `x86_64`.
    architectures: ?[]const Architecture = null,

    /// Configuration for the capacity provider that manages compute resources for
    /// Lambda functions.
    capacity_provider_config: ?CapacityProviderConfig = null,

    /// The code for the function.
    code: FunctionCode,

    /// To enable code signing for this function, specify the ARN of a code-signing
    /// configuration. A code-signing configuration includes a set of signing
    /// profiles, which define the trusted publishers for this function.
    code_signing_config_arn: ?[]const u8 = null,

    /// A dead-letter queue configuration that specifies the queue or topic where
    /// Lambda sends asynchronous events when they fail processing. For more
    /// information, see [Dead-letter
    /// queues](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#invocation-dlq).
    dead_letter_config: ?DeadLetterConfig = null,

    /// A description of the function.
    description: ?[]const u8 = null,

    /// Configuration settings for durable functions. Enables creating functions
    /// with durability that can remember their state and continue execution even
    /// after interruptions.
    durable_config: ?DurableConfig = null,

    /// Environment variables that are accessible from function code during
    /// execution.
    environment: ?Environment = null,

    /// The size of the function's `/tmp` directory in MB. The default value is 512,
    /// but can be any whole number between 512 and 10,240 MB. For more information,
    /// see [Configuring ephemeral storage
    /// (console)](https://docs.aws.amazon.com/lambda/latest/dg/configuration-function-common.html#configuration-ephemeral-storage).
    ephemeral_storage: ?EphemeralStorage = null,

    /// Connection settings for an Amazon EFS file system.
    file_system_configs: ?[]const FileSystemConfig = null,

    /// The name or ARN of the Lambda function. **Name formats**
    ///
    /// * **Function name** – `my-function`.
    /// * **Function ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:my-function`.
    /// * **Partial ARN** – `123456789012:function:my-function`.
    ///
    /// The length constraint applies only to the full ARN. If you specify only the
    /// function name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// The name of the method within your code that Lambda calls to run your
    /// function. Handler is required if the deployment package is a .zip file
    /// archive. The format includes the file name. It can also include namespaces
    /// and other qualifiers, depending on the runtime. For more information, see
    /// [Lambda programming
    /// model](https://docs.aws.amazon.com/lambda/latest/dg/foundation-progmodel.html).
    handler: ?[]const u8 = null,

    /// Container image [configuration
    /// values](https://docs.aws.amazon.com/lambda/latest/dg/images-create.html#images-parms) that override the values in the container image Dockerfile.
    image_config: ?ImageConfig = null,

    /// The ARN of the Key Management Service (KMS) customer managed key that's used
    /// to encrypt the following resources:
    ///
    /// * The function's [environment
    ///   variables](https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html#configuration-envvars-encryption).
    /// * The function's [Lambda
    ///   SnapStart](https://docs.aws.amazon.com/lambda/latest/dg/snapstart-security.html) snapshots.
    /// * When used with `SourceKMSKeyArn`, the unzipped version of the .zip
    ///   deployment package that's used for function invocations. For more
    ///   information, see [ Specifying a customer managed key for
    ///   Lambda](https://docs.aws.amazon.com/lambda/latest/dg/encrypt-zip-package.html#enable-zip-custom-encryption).
    /// * The optimized version of the container image that's used for function
    ///   invocations. Note that this is not the same key that's used to protect
    ///   your container image in the Amazon Elastic Container Registry (Amazon
    ///   ECR). For more information, see [Function
    ///   lifecycle](https://docs.aws.amazon.com/lambda/latest/dg/images-create.html#images-lifecycle).
    ///
    /// If you don't provide a customer managed key, Lambda uses an [Amazon Web
    /// Services owned
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-owned-cmk) or an [Amazon Web Services managed key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk).
    kms_key_arn: ?[]const u8 = null,

    /// A list of [function
    /// layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html) to add to the function's execution environment. Specify each layer by its ARN, including the version.
    layers: ?[]const []const u8 = null,

    /// The function's Amazon CloudWatch Logs configuration settings.
    logging_config: ?LoggingConfig = null,

    /// The amount of [memory available to the
    /// function](https://docs.aws.amazon.com/lambda/latest/dg/configuration-function-common.html#configuration-memory-console) at runtime. Increasing the function memory also increases its CPU allocation. The default value is 128 MB. The value can be any multiple of 1 MB.
    memory_size: ?i32 = null,

    /// The type of deployment package. Set to `Image` for container image and set
    /// to `Zip` for .zip file archive.
    package_type: ?PackageType = null,

    /// Set to true to publish the first version of the function during creation.
    publish: ?bool = null,

    /// Specifies where to publish the function version or configuration.
    publish_to: ?FunctionVersionLatestPublished = null,

    /// The Amazon Resource Name (ARN) of the function's execution role.
    role: []const u8,

    /// The identifier of the function's [
    /// runtime](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html).
    /// Runtime is required if the deployment package is a .zip file archive.
    /// Specifying a runtime results in an error if you're deploying a function
    /// using a container image.
    ///
    /// The following list includes deprecated runtimes. Lambda blocks creating new
    /// functions and updating existing functions shortly after each runtime is
    /// deprecated. For more information, see [Runtime use after
    /// deprecation](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html#runtime-deprecation-levels).
    ///
    /// For a list of all currently supported runtimes, see [Supported
    /// runtimes](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html#runtimes-supported).
    runtime: ?Runtime = null,

    /// The function's
    /// [SnapStart](https://docs.aws.amazon.com/lambda/latest/dg/snapstart.html)
    /// setting.
    snap_start: ?SnapStart = null,

    /// A list of [tags](https://docs.aws.amazon.com/lambda/latest/dg/tagging.html)
    /// to apply to the function.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Configuration for multi-tenant applications that use Lambda functions.
    /// Defines tenant isolation settings and resource allocations. Required for
    /// functions supporting multiple tenants.
    tenancy_config: ?TenancyConfig = null,

    /// The amount of time (in seconds) that Lambda allows a function to run before
    /// stopping it. The default is 3 seconds. The maximum allowed value is 900
    /// seconds. For more information, see [Lambda execution
    /// environment](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-context.html).
    timeout: ?i32 = null,

    /// Set `Mode` to `Active` to sample and trace a subset of incoming requests
    /// with
    /// [X-Ray](https://docs.aws.amazon.com/lambda/latest/dg/services-xray.html).
    tracing_config: ?TracingConfig = null,

    /// For network connectivity to Amazon Web Services resources in a VPC, specify
    /// a list of security groups and subnets in the VPC. When you connect a
    /// function to a VPC, it can access resources and the internet only through
    /// that VPC. For more information, see [Configuring a Lambda function to access
    /// resources in a
    /// VPC](https://docs.aws.amazon.com/lambda/latest/dg/configuration-vpc.html).
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .architectures = "Architectures",
        .capacity_provider_config = "CapacityProviderConfig",
        .code = "Code",
        .code_signing_config_arn = "CodeSigningConfigArn",
        .dead_letter_config = "DeadLetterConfig",
        .description = "Description",
        .durable_config = "DurableConfig",
        .environment = "Environment",
        .ephemeral_storage = "EphemeralStorage",
        .file_system_configs = "FileSystemConfigs",
        .function_name = "FunctionName",
        .handler = "Handler",
        .image_config = "ImageConfig",
        .kms_key_arn = "KMSKeyArn",
        .layers = "Layers",
        .logging_config = "LoggingConfig",
        .memory_size = "MemorySize",
        .package_type = "PackageType",
        .publish = "Publish",
        .publish_to = "PublishTo",
        .role = "Role",
        .runtime = "Runtime",
        .snap_start = "SnapStart",
        .tags = "Tags",
        .tenancy_config = "TenancyConfig",
        .timeout = "Timeout",
        .tracing_config = "TracingConfig",
        .vpc_config = "VpcConfig",
    };
};

const CreateFunctionOutput = @import("function_configuration.zig").FunctionConfiguration;

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFunctionInput, options: Options) !CreateFunctionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lambda");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2015-03-31/functions";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.architectures) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Architectures\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.capacity_provider_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"CapacityProviderConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Code\":");
    try aws.json.writeValue(@TypeOf(input.code), input.code, alloc, &body_buf);
    has_prev = true;
    if (input.code_signing_config_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"CodeSigningConfigArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.dead_letter_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DeadLetterConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.durable_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DurableConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.environment) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Environment\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.ephemeral_storage) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EphemeralStorage\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.file_system_configs) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"FileSystemConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"FunctionName\":");
    try aws.json.writeValue(@TypeOf(input.function_name), input.function_name, alloc, &body_buf);
    has_prev = true;
    if (input.handler) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Handler\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.image_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ImageConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"KMSKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.layers) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Layers\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.logging_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"LoggingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.memory_size) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MemorySize\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.package_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"PackageType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.publish) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Publish\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.publish_to) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"PublishTo\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Role\":");
    try aws.json.writeValue(@TypeOf(input.role), input.role, alloc, &body_buf);
    has_prev = true;
    if (input.runtime) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Runtime\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.snap_start) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SnapStart\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tenancy_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"TenancyConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.timeout) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Timeout\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tracing_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"TracingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.vpc_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"VpcConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateFunctionOutput {
    var result: CreateFunctionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFunctionOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "CallbackTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .callback_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityProviderLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .capacity_provider_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeSigningConfigNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .code_signing_config_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeStorageExceededException")) {
        return .{ .arena = arena, .kind = .{ .code_storage_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeVerificationFailedException")) {
        return .{ .arena = arena, .kind = .{ .code_verification_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DurableExecutionAlreadyStartedException")) {
        return .{ .arena = arena, .kind = .{ .durable_execution_already_started_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EC2AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .ec2_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EC2ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .ec2_throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EC2UnexpectedException")) {
        return .{ .arena = arena, .kind = .{ .ec2_unexpected_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountConnectivityException")) {
        return .{ .arena = arena, .kind = .{ .efs_mount_connectivity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountFailureException")) {
        return .{ .arena = arena, .kind = .{ .efs_mount_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .efs_mount_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSIOException")) {
        return .{ .arena = arena, .kind = .{ .efsio_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ENILimitReachedException")) {
        return .{ .arena = arena, .kind = .{ .eni_limit_reached_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FunctionVersionsPerCapacityProviderLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .function_versions_per_capacity_provider_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCodeSignatureException")) {
        return .{ .arena = arena, .kind = .{ .invalid_code_signature_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestContentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRuntimeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_runtime_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityGroupIDException")) {
        return .{ .arena = arena, .kind = .{ .invalid_security_group_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnetIDException")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidZipFileException")) {
        return .{ .arena = arena, .kind = .{ .invalid_zip_file_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoPublishedVersionException")) {
        return .{ .arena = arena, .kind = .{ .no_published_version_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedConcurrencyConfigNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .provisioned_concurrency_config_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RecursiveInvocationException")) {
        return .{ .arena = arena, .kind = .{ .recursive_invocation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .request_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .arena = arena, .kind = .{ .resource_conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SerializedRequestEntityTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .serialized_request_entity_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetIPAddressLimitReachedException")) {
        return .{ .arena = arena, .kind = .{ .subnet_ip_address_limit_reached_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedMediaTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_media_type_exception = .{
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
