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

/// Creates a Lambda function. To create a function, you need a [deployment
/// package](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-package.html) and an [execution role](https://docs.aws.amazon.com/lambda/latest/dg/intro-permission-model.html#lambda-intro-execution-role). The deployment package is a .zip file archive or container image that contains your function code. The execution role grants the function permission to use Amazon Web Services services, such as Amazon CloudWatch Logs for log streaming and X-Ray for request tracing.
///
/// If the deployment package is a [container
/// image](https://docs.aws.amazon.com/lambda/latest/dg/lambda-images.html),
/// then you set the package type to `Image`. For a container image, the code
/// property must include the URI of a container image in the Amazon ECR
/// registry. You do not need to specify the handler and runtime properties.
///
/// If the deployment package is a [.zip file
/// archive](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-package.html#gettingstarted-package-zip), then you set the package type to `Zip`. For a .zip file archive, the code property specifies the location of the .zip file. You must also specify the handler and runtime properties. The code in the deployment package must be compatible with the target instruction set architecture of the function (`x86-64` or `arm64`). If you do not specify the architecture, then the default value is `x86-64`.
///
/// When you create a function, Lambda provisions an instance of the function
/// and its supporting resources. If your function connects to a VPC, this
/// process can take a minute or so. During this time, you can't invoke or
/// modify the function. The `State`, `StateReason`, and `StateReasonCode`
/// fields in the response from GetFunctionConfiguration indicate when the
/// function is ready to invoke. For more information, see [Lambda function
/// states](https://docs.aws.amazon.com/lambda/latest/dg/functions-states.html).
///
/// A function has an unpublished version, and can have published versions and
/// aliases. The unpublished version changes when you update your function's
/// code and configuration. A published version is a snapshot of your function
/// code and configuration that can't be changed. An alias is a named resource
/// that maps to a version, and can be changed to map to a different version.
/// Use the `Publish` parameter to create version `1` of your function from its
/// initial configuration.
///
/// The other parameters let you configure version-specific and function-level
/// settings. You can modify version-specific settings later with
/// UpdateFunctionConfiguration. Function-level settings apply to both the
/// unpublished and published versions of the function, and include tags
/// (TagResource) and per-function concurrency limits (PutFunctionConcurrency).
///
/// You can use code signing if your deployment package is a .zip file archive.
/// To enable code signing for this function, specify the ARN of a code-signing
/// configuration. When a user attempts to deploy a code package with
/// UpdateFunctionCode, Lambda checks that the code package has a valid
/// signature from a trusted publisher. The code-signing configuration includes
/// set of signing profiles, which define the trusted publishers for this
/// function.
///
/// If another Amazon Web Services account or an Amazon Web Services service
/// invokes your function, use AddPermission to grant permission by creating a
/// resource-based Identity and Access Management (IAM) policy. You can grant
/// permissions at the function level, on a version, or on an alias.
///
/// To invoke your function directly, use Invoke. To invoke your function in
/// response to events in other Amazon Web Services services, create an event
/// source mapping (CreateEventSourceMapping), or configure a function trigger
/// in the other service. For more information, see [Invoking Lambda
/// functions](https://docs.aws.amazon.com/lambda/latest/dg/lambda-invocation.html).
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
    tags: ?[]const u8 = null,

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

pub const CreateFunctionOutput = struct {
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

    pub fn deinit(self: *CreateFunctionOutput) void {
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

pub fn execute(client: *Client, input: CreateFunctionInput, options: Options) !CreateFunctionOutput {
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("lambda", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

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
