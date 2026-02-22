const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Architecture = @import("architecture.zig").Architecture;
const FunctionVersionLatestPublished = @import("function_version_latest_published.zig").FunctionVersionLatestPublished;
const CapacityProviderConfig = @import("capacity_provider_config.zig").CapacityProviderConfig;
const DeadLetterConfig = @import("dead_letter_config.zig").DeadLetterConfig;
const DurableConfig = @import("durable_config.zig").DurableConfig;
const EnvironmentResponse = @import("environment_response.zig").EnvironmentResponse;
const EphemeralStorage = @import("ephemeral_storage.zig").EphemeralStorage;
const FileSystemConfig = @import("file_system_config.zig").FileSystemConfig;
const ImageConfigResponse = @import("image_config_response.zig").ImageConfigResponse;
const LastUpdateStatus = @import("last_update_status.zig").LastUpdateStatus;
const LastUpdateStatusReasonCode = @import("last_update_status_reason_code.zig").LastUpdateStatusReasonCode;
const Layer = @import("layer.zig").Layer;
const LoggingConfig = @import("logging_config.zig").LoggingConfig;
const PackageType = @import("package_type.zig").PackageType;
const Runtime = @import("runtime.zig").Runtime;
const RuntimeVersionConfig = @import("runtime_version_config.zig").RuntimeVersionConfig;
const SnapStartResponse = @import("snap_start_response.zig").SnapStartResponse;
const State = @import("state.zig").State;
const StateReasonCode = @import("state_reason_code.zig").StateReasonCode;
const TenancyConfig = @import("tenancy_config.zig").TenancyConfig;
const TracingConfigResponse = @import("tracing_config_response.zig").TracingConfigResponse;
const VpcConfigResponse = @import("vpc_config_response.zig").VpcConfigResponse;

pub const UpdateFunctionCodeInput = struct {
    /// The instruction set architecture that the function supports. Enter a string
    /// array with one of the valid values (arm64 or x86_64). The default value is
    /// `x86_64`.
    architectures: ?[]const Architecture = null,

    /// Set to true to validate the request parameters and access permissions
    /// without modifying the function code.
    dry_run: ?bool = null,

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

    /// URI of a container image in the Amazon ECR registry. Do not use for a
    /// function defined with a .zip file archive.
    image_uri: ?[]const u8 = null,

    /// Set to true to publish a new version of the function after updating the
    /// code. This has the same effect as calling PublishVersion separately.
    publish: ?bool = null,

    /// Specifies where to publish the function version or configuration.
    publish_to: ?FunctionVersionLatestPublished = null,

    /// Update the function only if the revision ID matches the ID that's specified.
    /// Use this option to avoid modifying a function that has changed since you
    /// last read it.
    revision_id: ?[]const u8 = null,

    /// An Amazon S3 bucket in the same Amazon Web Services Region as your function.
    /// The bucket can be in a different Amazon Web Services account. Use only with
    /// a function defined with a .zip file archive deployment package.
    s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key of the deployment package. Use only with a function
    /// defined with a .zip file archive deployment package.
    s3_key: ?[]const u8 = null,

    /// For versioned objects, the version of the deployment package object to use.
    s3_object_version: ?[]const u8 = null,

    /// The ARN of the Key Management Service (KMS) customer managed key that's used
    /// to encrypt your function's .zip deployment package. If you don't provide a
    /// customer managed key, Lambda uses an Amazon Web Services managed key.
    source_kms_key_arn: ?[]const u8 = null,

    /// The base64-encoded contents of the deployment package. Amazon Web Services
    /// SDK and CLI clients handle the encoding for you. Use only with a function
    /// defined with a .zip file archive deployment package.
    zip_file: ?[]const u8 = null,

    pub const json_field_names = .{
        .architectures = "Architectures",
        .dry_run = "DryRun",
        .function_name = "FunctionName",
        .image_uri = "ImageUri",
        .publish = "Publish",
        .publish_to = "PublishTo",
        .revision_id = "RevisionId",
        .s3_bucket = "S3Bucket",
        .s3_key = "S3Key",
        .s3_object_version = "S3ObjectVersion",
        .source_kms_key_arn = "SourceKMSKeyArn",
        .zip_file = "ZipFile",
    };
};

pub const UpdateFunctionCodeOutput = struct {
    /// The instruction set architecture that the function supports. Architecture is
    /// a string array with one of the valid values. The default architecture value
    /// is `x86_64`.
    architectures: ?[]const Architecture = null,

    /// Configuration for the capacity provider that manages compute resources for
    /// Lambda functions.
    capacity_provider_config: ?CapacityProviderConfig = null,

    /// The SHA256 hash of the function's deployment package.
    code_sha_256: ?[]const u8 = null,

    /// The size of the function's deployment package, in bytes.
    code_size: ?i64 = null,

    /// The SHA256 hash of the function configuration.
    config_sha_256: ?[]const u8 = null,

    /// The function's dead letter queue.
    dead_letter_config: ?DeadLetterConfig = null,

    /// The function's description.
    description: ?[]const u8 = null,

    /// The function's durable execution configuration settings, if the function is
    /// configured for durability.
    durable_config: ?DurableConfig = null,

    /// The function's [environment
    /// variables](https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html). Omitted from CloudTrail logs.
    environment: ?EnvironmentResponse = null,

    /// The size of the function's `/tmp` directory in MB. The default value is 512,
    /// but can be any whole number between 512 and 10,240 MB. For more information,
    /// see [Configuring ephemeral storage
    /// (console)](https://docs.aws.amazon.com/lambda/latest/dg/configuration-function-common.html#configuration-ephemeral-storage).
    ephemeral_storage: ?EphemeralStorage = null,

    /// Connection settings for an [Amazon EFS file
    /// system](https://docs.aws.amazon.com/lambda/latest/dg/configuration-filesystem.html).
    file_system_configs: ?[]const FileSystemConfig = null,

    /// The function's Amazon Resource Name (ARN).
    function_arn: ?[]const u8 = null,

    /// The name of the function.
    function_name: ?[]const u8 = null,

    /// The function that Lambda calls to begin running your function.
    handler: ?[]const u8 = null,

    /// The function's image configuration values.
    image_config_response: ?ImageConfigResponse = null,

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

    /// The date and time that the function was last updated, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    last_modified: ?[]const u8 = null,

    /// The status of the last update that was performed on the function. This is
    /// first set to `Successful` after function creation completes.
    last_update_status: ?LastUpdateStatus = null,

    /// The reason for the last update that was performed on the function.
    last_update_status_reason: ?[]const u8 = null,

    /// The reason code for the last update that was performed on the function.
    last_update_status_reason_code: ?LastUpdateStatusReasonCode = null,

    /// The function's
    /// [layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html).
    layers: ?[]const Layer = null,

    /// The function's Amazon CloudWatch Logs configuration settings.
    logging_config: ?LoggingConfig = null,

    /// For Lambda@Edge functions, the ARN of the main function.
    master_arn: ?[]const u8 = null,

    /// The amount of memory available to the function at runtime.
    memory_size: ?i32 = null,

    /// The type of deployment package. Set to `Image` for container image and set
    /// `Zip` for .zip file archive.
    package_type: ?PackageType = null,

    /// The latest updated revision of the function or alias.
    revision_id: ?[]const u8 = null,

    /// The function's execution role.
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

    /// The ARN of the runtime and any errors that occured.
    runtime_version_config: ?RuntimeVersionConfig = null,

    /// The ARN of the signing job.
    signing_job_arn: ?[]const u8 = null,

    /// The ARN of the signing profile version.
    signing_profile_version_arn: ?[]const u8 = null,

    /// Set `ApplyOn` to `PublishedVersions` to create a snapshot of the initialized
    /// execution environment when you publish a function version. For more
    /// information, see [Improving startup performance with Lambda
    /// SnapStart](https://docs.aws.amazon.com/lambda/latest/dg/snapstart.html).
    snap_start: ?SnapStartResponse = null,

    /// The current state of the function. When the state is `Inactive`, you can
    /// reactivate the function by invoking it.
    state: ?State = null,

    /// The reason for the function's current state.
    state_reason: ?[]const u8 = null,

    /// The reason code for the function's current state. When the code is
    /// `Creating`, you can't invoke or modify the function.
    state_reason_code: ?StateReasonCode = null,

    /// The function's tenant isolation configuration settings. Determines whether
    /// the Lambda function runs on a shared or dedicated infrastructure per unique
    /// tenant.
    tenancy_config: ?TenancyConfig = null,

    /// The amount of time in seconds that Lambda allows a function to run before
    /// stopping it.
    timeout: ?i32 = null,

    /// The function's X-Ray tracing configuration.
    tracing_config: ?TracingConfigResponse = null,

    /// The version of the Lambda function.
    version: ?[]const u8 = null,

    /// The function's networking configuration.
    vpc_config: ?VpcConfigResponse = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *UpdateFunctionCodeOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .architectures = "Architectures",
        .capacity_provider_config = "CapacityProviderConfig",
        .code_sha_256 = "CodeSha256",
        .code_size = "CodeSize",
        .config_sha_256 = "ConfigSha256",
        .dead_letter_config = "DeadLetterConfig",
        .description = "Description",
        .durable_config = "DurableConfig",
        .environment = "Environment",
        .ephemeral_storage = "EphemeralStorage",
        .file_system_configs = "FileSystemConfigs",
        .function_arn = "FunctionArn",
        .function_name = "FunctionName",
        .handler = "Handler",
        .image_config_response = "ImageConfigResponse",
        .kms_key_arn = "KMSKeyArn",
        .last_modified = "LastModified",
        .last_update_status = "LastUpdateStatus",
        .last_update_status_reason = "LastUpdateStatusReason",
        .last_update_status_reason_code = "LastUpdateStatusReasonCode",
        .layers = "Layers",
        .logging_config = "LoggingConfig",
        .master_arn = "MasterArn",
        .memory_size = "MemorySize",
        .package_type = "PackageType",
        .revision_id = "RevisionId",
        .role = "Role",
        .runtime = "Runtime",
        .runtime_version_config = "RuntimeVersionConfig",
        .signing_job_arn = "SigningJobArn",
        .signing_profile_version_arn = "SigningProfileVersionArn",
        .snap_start = "SnapStart",
        .state = "State",
        .state_reason = "StateReason",
        .state_reason_code = "StateReasonCode",
        .tenancy_config = "TenancyConfig",
        .timeout = "Timeout",
        .tracing_config = "TracingConfig",
        .version = "Version",
        .vpc_config = "VpcConfig",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: UpdateFunctionCodeInput, options: Options) !UpdateFunctionCodeOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateFunctionCodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/2015-03-31/functions/");
    try path_buf.appendSlice(alloc, input.function_name);
    try path_buf.appendSlice(alloc, "/code");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.architectures) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Architectures\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.image_uri) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ImageUri\":");
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
    if (input.revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"RevisionId\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.s3_bucket) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"S3Bucket\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.s3_key) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"S3Key\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.s3_object_version) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"S3ObjectVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.source_kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SourceKMSKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.zip_file) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ZipFile\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateFunctionCodeOutput {
    var result: UpdateFunctionCodeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateFunctionCodeOutput, body, alloc);
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
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, "");
    errdefer alloc.free(owned_request_id);

    if (std.mem.eql(u8, error_code, "CallbackTimeoutException")) {
        return .{ .callback_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "CapacityProviderLimitExceededException")) {
        return .{ .capacity_provider_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "CodeSigningConfigNotFoundException")) {
        return .{ .code_signing_config_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "CodeStorageExceededException")) {
        return .{ .code_storage_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "CodeVerificationFailedException")) {
        return .{ .code_verification_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "DurableExecutionAlreadyStartedException")) {
        return .{ .durable_execution_already_started_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "EC2AccessDeniedException")) {
        return .{ .ec2_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "EC2ThrottledException")) {
        return .{ .ec2_throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "EC2UnexpectedException")) {
        return .{ .ec2_unexpected_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountConnectivityException")) {
        return .{ .efs_mount_connectivity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountFailureException")) {
        return .{ .efs_mount_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountTimeoutException")) {
        return .{ .efs_mount_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSIOException")) {
        return .{ .efsio_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ENILimitReachedException")) {
        return .{ .eni_limit_reached_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "FunctionVersionsPerCapacityProviderLimitExceededException")) {
        return .{ .function_versions_per_capacity_provider_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCodeSignatureException")) {
        return .{ .invalid_code_signature_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestContentException")) {
        return .{ .invalid_request_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRuntimeException")) {
        return .{ .invalid_runtime_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityGroupIDException")) {
        return .{ .invalid_security_group_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnetIDException")) {
        return .{ .invalid_subnet_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidZipFileException")) {
        return .{ .invalid_zip_file_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .kms_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .kms_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .kms_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .kms_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoPublishedVersionException")) {
        return .{ .no_published_version_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        return .{ .policy_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedConcurrencyConfigNotFoundException")) {
        return .{ .provisioned_concurrency_config_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "RecursiveInvocationException")) {
        return .{ .recursive_invocation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "RequestTooLargeException")) {
        return .{ .request_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .resource_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .resource_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "SerializedRequestEntityTooLargeException")) {
        return .{ .serialized_request_entity_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartException")) {
        return .{ .snap_start_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartNotReadyException")) {
        return .{ .snap_start_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartTimeoutException")) {
        return .{ .snap_start_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "SubnetIPAddressLimitReachedException")) {
        return .{ .subnet_ip_address_limit_reached_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedMediaTypeException")) {
        return .{ .unsupported_media_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }

    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
