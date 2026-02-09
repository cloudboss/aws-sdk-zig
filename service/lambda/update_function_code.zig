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

/// Updates a Lambda function's code. If code signing is enabled for the
/// function, the code package must be signed by a trusted publisher. For more
/// information, see [Configuring code signing for
/// Lambda](https://docs.aws.amazon.com/lambda/latest/dg/configuration-codesigning.html).
///
/// If the function's package type is `Image`, then you must specify the code
/// package in `ImageUri` as the URI of a [container
/// image](https://docs.aws.amazon.com/lambda/latest/dg/lambda-images.html) in
/// the Amazon ECR registry.
///
/// If the function's package type is `Zip`, then you must specify the
/// deployment package as a [.zip file
/// archive](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-package.html#gettingstarted-package-zip). Enter the Amazon S3 bucket and key of the code .zip file location. You can also provide the function code inline using the `ZipFile` field.
///
/// The code in the deployment package must be compatible with the target
/// instruction set architecture of the function (`x86-64` or `arm64`).
///
/// The function's code is locked when you publish a version. You can't modify
/// the code of a published version, only the unpublished version.
///
/// **Note:**
///
/// For a function defined as a container image, Lambda resolves the image tag
/// to an image digest. In Amazon ECR, if you update the image tag to a new
/// image, Lambda does not automatically update the function.
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
    s_3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key of the deployment package. Use only with a function
    /// defined with a .zip file archive deployment package.
    s_3_key: ?[]const u8 = null,

    /// For versioned objects, the version of the deployment package object to use.
    s_3_object_version: ?[]const u8 = null,

    /// The ARN of the Key Management Service (KMS) customer managed key that's used
    /// to encrypt your function's .zip deployment package. If you don't provide a
    /// customer managed key, Lambda uses an Amazon Web Services managed key.
    source_kms_key_arn: ?[]const u8 = null,

    /// The base64-encoded contents of the deployment package. Amazon Web Services
    /// SDK and CLI clients handle the encoding for you. Use only with a function
    /// defined with a .zip file archive deployment package.
    zip_file: ?[]const u8 = null,
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const UpdateFunctionCodeOutput) void {
        if (self.code_sha_256) |v| {
            self.allocator.free(v);
        }
        if (self.config_sha_256) |v| {
            self.allocator.free(v);
        }
        if (self.description) |v| {
            self.allocator.free(v);
        }
        if (self.function_arn) |v| {
            self.allocator.free(v);
        }
        if (self.function_name) |v| {
            self.allocator.free(v);
        }
        if (self.handler) |v| {
            self.allocator.free(v);
        }
        if (self.kms_key_arn) |v| {
            self.allocator.free(v);
        }
        if (self.last_modified) |v| {
            self.allocator.free(v);
        }
        if (self.last_update_status_reason) |v| {
            self.allocator.free(v);
        }
        if (self.master_arn) |v| {
            self.allocator.free(v);
        }
        if (self.revision_id) |v| {
            self.allocator.free(v);
        }
        if (self.role) |v| {
            self.allocator.free(v);
        }
        if (self.signing_job_arn) |v| {
            self.allocator.free(v);
        }
        if (self.signing_profile_version_arn) |v| {
            self.allocator.free(v);
        }
        if (self.state_reason) |v| {
            self.allocator.free(v);
        }
        if (self.version) |v| {
            self.allocator.free(v);
        }
    }
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateFunctionCodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("lambda", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/2015-03-31/functions/");
    try path_buf.appendSlice(alloc, input.function_name);
    try path_buf.appendSlice(alloc, "/code");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DryRun\":");
        try body_buf.appendSlice(alloc, if (v) "true" else "false");
        has_prev = true;
    }
    if (input.image_uri) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ImageUri\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.publish) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Publish\":");
        try body_buf.appendSlice(alloc, if (v) "true" else "false");
        has_prev = true;
    }
    if (input.revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"RevisionId\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.s_3_bucket) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"S3Bucket\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.s_3_key) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"S3Key\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.s_3_object_version) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"S3ObjectVersion\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.source_kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SourceKMSKeyArn\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
        has_prev = true;
    }
    if (input.zip_file) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ZipFile\":\"");
        try appendJsonEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "\"");
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !UpdateFunctionCodeOutput {
    var result: UpdateFunctionCodeOutput = .{ .allocator = alloc };
    _ = status;
    if (findJsonValue(body, "CodeSha256")) |content| {
        result.code_sha_256 = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "CodeSize")) |content| {
        result.code_size = std.fmt.parseInt(i64, content, 10) catch null;
    }
    if (findJsonValue(body, "ConfigSha256")) |content| {
        result.config_sha_256 = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "Description")) |content| {
        result.description = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "FunctionArn")) |content| {
        result.function_arn = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "FunctionName")) |content| {
        result.function_name = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "Handler")) |content| {
        result.handler = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "KMSKeyArn")) |content| {
        result.kms_key_arn = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "LastModified")) |content| {
        result.last_modified = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "LastUpdateStatusReason")) |content| {
        result.last_update_status_reason = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "MasterArn")) |content| {
        result.master_arn = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "MemorySize")) |content| {
        result.memory_size = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findJsonValue(body, "RevisionId")) |content| {
        result.revision_id = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "Role")) |content| {
        result.role = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "SigningJobArn")) |content| {
        result.signing_job_arn = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "SigningProfileVersionArn")) |content| {
        result.signing_profile_version_arn = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "StateReason")) |content| {
        result.state_reason = try alloc.dupe(u8, content);
    }
    if (findJsonValue(body, "Timeout")) |content| {
        result.timeout = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findJsonValue(body, "Version")) |content| {
        result.version = try alloc.dupe(u8, content);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = findJsonValue(body, "message") orelse findJsonValue(body, "Message") orelse "";

    if (std.mem.eql(u8, error_code, "CallbackTimeoutException")) {
        return .{ .callback_timeout_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CapacityProviderLimitExceededException")) {
        return .{ .capacity_provider_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CodeSigningConfigNotFoundException")) {
        return .{ .code_signing_config_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CodeStorageExceededException")) {
        return .{ .code_storage_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CodeVerificationFailedException")) {
        return .{ .code_verification_failed_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DurableExecutionAlreadyStartedException")) {
        return .{ .durable_execution_already_started_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EC2AccessDeniedException")) {
        return .{ .ec2_access_denied_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EC2ThrottledException")) {
        return .{ .ec2_throttled_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EC2UnexpectedException")) {
        return .{ .ec2_unexpected_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountConnectivityException")) {
        return .{ .efs_mount_connectivity_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountFailureException")) {
        return .{ .efs_mount_failure_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountTimeoutException")) {
        return .{ .efs_mount_timeout_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSIOException")) {
        return .{ .efsio_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ENILimitReachedException")) {
        return .{ .eni_limit_reached_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "FunctionVersionsPerCapacityProviderLimitExceededException")) {
        return .{ .function_versions_per_capacity_provider_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCodeSignatureException")) {
        return .{ .invalid_code_signature_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .invalid_parameter_value_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestContentException")) {
        return .{ .invalid_request_content_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRuntimeException")) {
        return .{ .invalid_runtime_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityGroupIDException")) {
        return .{ .invalid_security_group_id_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnetIDException")) {
        return .{ .invalid_subnet_id_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidZipFileException")) {
        return .{ .invalid_zip_file_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .kms_access_denied_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .kms_disabled_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .kms_invalid_state_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .kms_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "NoPublishedVersionException")) {
        return .{ .no_published_version_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        return .{ .policy_length_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .precondition_failed_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedConcurrencyConfigNotFoundException")) {
        return .{ .provisioned_concurrency_config_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "RecursiveInvocationException")) {
        return .{ .recursive_invocation_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "RequestTooLargeException")) {
        return .{ .request_too_large_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .resource_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .resource_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .resource_not_ready_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SerializedRequestEntityTooLargeException")) {
        return .{ .serialized_request_entity_too_large_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .service_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartException")) {
        return .{ .snap_start_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartNotReadyException")) {
        return .{ .snap_start_not_ready_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartTimeoutException")) {
        return .{ .snap_start_timeout_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SubnetIPAddressLimitReachedException")) {
        return .{ .subnet_ip_address_limit_reached_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .too_many_requests_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedMediaTypeException")) {
        return .{ .unsupported_media_type_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = "",
        .http_status = status,
    } };
}

fn findJsonValue(json: []const u8, key: []const u8) ?[]const u8 {
    var buf: [258]u8 = undefined;
    if (key.len + 2 > buf.len) return null;
    buf[0] = 0x22;
    @memcpy(buf[1..][0..key.len], key);
    buf[key.len + 1] = 0x22;
    const search = buf[0 .. key.len + 2];
    const key_start = std.mem.indexOf(u8, json, search) orelse return null;
    var pos = key_start + search.len;

    while (pos < json.len) : (pos += 1) {
        if (json[pos] != ' ' and json[pos] != ':') break;
    }
    if (pos >= json.len) return null;

    if (json[pos] == 0x22) {
        const start = pos + 1;
        const end = std.mem.indexOfScalarPos(u8, json, start, 0x22) orelse return null;
        return json[start..end];
    }

    const start = pos;
    while (pos < json.len) : (pos += 1) {
        if (json[pos] == ',' or json[pos] == '}' or json[pos] == ' ') break;
    }
    return json[start..pos];
}

fn appendJsonEscaped(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            0x22 => { try buf.append(alloc, 0x5C); try buf.append(alloc, 0x22); },
            0x5C => { try buf.append(alloc, 0x5C); try buf.append(alloc, 0x5C); },
            0x0A => { try buf.append(alloc, 0x5C); try buf.append(alloc, 'n'); },
            0x0D => { try buf.append(alloc, 0x5C); try buf.append(alloc, 'r'); },
            0x09 => { try buf.append(alloc, 0x5C); try buf.append(alloc, 't'); },
            else => {
                if (c < 0x20) {
                    const hex = "0123456789abcdef";
                    try buf.append(alloc, 0x5C);
                    try buf.append(alloc, 'u');
                    try buf.append(alloc, '0');
                    try buf.append(alloc, '0');
                    try buf.append(alloc, hex[c >> 4]);
                    try buf.append(alloc, hex[c & 0x0F]);
                } else {
                    try buf.append(alloc, c);
                }
            }
        }
    }
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
