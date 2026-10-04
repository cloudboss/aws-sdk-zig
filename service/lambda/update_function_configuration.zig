const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityProviderConfig = @import("capacity_provider_config.zig").CapacityProviderConfig;
const DeadLetterConfig = @import("dead_letter_config.zig").DeadLetterConfig;
const DurableConfig = @import("durable_config.zig").DurableConfig;
const Environment = @import("environment.zig").Environment;
const EphemeralStorage = @import("ephemeral_storage.zig").EphemeralStorage;
const FileSystemConfig = @import("file_system_config.zig").FileSystemConfig;
const ImageConfig = @import("image_config.zig").ImageConfig;
const LoggingConfig = @import("logging_config.zig").LoggingConfig;
const Runtime = @import("runtime.zig").Runtime;
const SnapStart = @import("snap_start.zig").SnapStart;
const TracingConfig = @import("tracing_config.zig").TracingConfig;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const Architecture = @import("architecture.zig").Architecture;
const EnvironmentResponse = @import("environment_response.zig").EnvironmentResponse;
const ImageConfigResponse = @import("image_config_response.zig").ImageConfigResponse;
const LastUpdateStatus = @import("last_update_status.zig").LastUpdateStatus;
const LastUpdateStatusReasonCode = @import("last_update_status_reason_code.zig").LastUpdateStatusReasonCode;
const Layer = @import("layer.zig").Layer;
const PackageType = @import("package_type.zig").PackageType;
const RuntimeVersionConfig = @import("runtime_version_config.zig").RuntimeVersionConfig;
const SnapStartResponse = @import("snap_start_response.zig").SnapStartResponse;
const State = @import("state.zig").State;
const StateReasonCode = @import("state_reason_code.zig").StateReasonCode;
const TenancyConfig = @import("tenancy_config.zig").TenancyConfig;
const TracingConfigResponse = @import("tracing_config_response.zig").TracingConfigResponse;
const VpcConfigResponse = @import("vpc_config_response.zig").VpcConfigResponse;

pub const UpdateFunctionConfigurationInput = struct {
    /// Configuration for the capacity provider that manages compute resources for
    /// Lambda functions.
    capacity_provider_config: ?CapacityProviderConfig = null,

    /// A dead-letter queue configuration that specifies the queue or topic where
    /// Lambda sends asynchronous events when they fail processing. For more
    /// information, see [Dead-letter
    /// queues](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#invocation-dlq).
    dead_letter_config: ?DeadLetterConfig = null,

    /// A description of the function.
    description: ?[]const u8 = null,

    /// Configuration settings for [durable
    /// functions](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html), including execution timeout, retention period for execution history, and an optional ARN of the Key Management Service (KMS) customer managed key that is used to encrypt your durable execution's payload data, including input, output, and error payloads.
    durable_config: ?DurableConfig = null,

    /// Environment variables that are accessible from function code during
    /// execution.
    environment: ?Environment = null,

    /// The size of the function's `/tmp` directory in MB. The default value is 512,
    /// but can be any whole number between 512 and 10,240 MB. For more information,
    /// see [Configuring ephemeral storage
    /// (console)](https://docs.aws.amazon.com/lambda/latest/dg/configuration-function-common.html#configuration-ephemeral-storage).
    ephemeral_storage: ?EphemeralStorage = null,

    /// Connection settings for an Amazon EFS file system or an Amazon S3 Files file
    /// system.
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

    /// [Container image configuration
    /// values](https://docs.aws.amazon.com/lambda/latest/dg/images-create.html#images-parms) that override the values in the container image Docker file.
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

    /// Update the function only if the revision ID matches the ID that's specified.
    /// Use this option to avoid modifying a function that has changed since you
    /// last read it.
    revision_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the function's execution role.
    role: ?[]const u8 = null,

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

    /// The amount of time (in seconds) that Lambda allows a function to run before
    /// stopping it. The default is 3 seconds, and the maximum allowed value is 900
    /// seconds. For functions using Lambda Managed Instances, asynchronous
    /// invocations and event source mapping invocations (except Amazon MQ and
    /// Amazon DocumentDB) support a maximum allowed value of 5,400 seconds (90
    /// minutes). For more information, see [Lambda execution
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
        .capacity_provider_config = "CapacityProviderConfig",
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
        .revision_id = "RevisionId",
        .role = "Role",
        .runtime = "Runtime",
        .snap_start = "SnapStart",
        .timeout = "Timeout",
        .tracing_config = "TracingConfig",
        .vpc_config = "VpcConfig",
    };
};

pub const UpdateFunctionConfigurationOutput = @import("function_configuration.zig").FunctionConfiguration;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFunctionConfigurationInput, options: CallOptions) !UpdateFunctionConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFunctionConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-03-31/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/configuration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.capacity_provider_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CapacityProviderConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dead_letter_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeadLetterConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.durable_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DurableConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Environment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ephemeral_storage) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EphemeralStorage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.file_system_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FileSystemConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.handler) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Handler\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.image_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ImageConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KMSKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.layers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Layers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.logging_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LoggingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.memory_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MemorySize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RevisionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Role\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.runtime) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Runtime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.snap_start) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SnapStart\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.timeout) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Timeout\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tracing_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TracingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VpcConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFunctionConfigurationOutput {
    const result: UpdateFunctionConfigurationOutput = try aws.json.parseJsonObject(
        UpdateFunctionConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
