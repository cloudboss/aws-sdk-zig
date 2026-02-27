const Architecture = @import("architecture.zig").Architecture;
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

/// Details about a function's configuration.
pub const FunctionConfiguration = struct {
    /// The instruction set architecture that the function supports. Architecture is
    /// a string array with one of the valid values. The default architecture value
    /// is `x86_64`.
    architectures: ?[]const Architecture,

    /// Configuration for the capacity provider that manages compute resources for
    /// Lambda functions.
    capacity_provider_config: ?CapacityProviderConfig,

    /// The SHA256 hash of the function's deployment package.
    code_sha_256: ?[]const u8,

    /// The size of the function's deployment package, in bytes.
    code_size: i64 = 0,

    /// The SHA256 hash of the function configuration.
    config_sha_256: ?[]const u8,

    /// The function's dead letter queue.
    dead_letter_config: ?DeadLetterConfig,

    /// The function's description.
    description: ?[]const u8,

    /// The function's durable execution configuration settings, if the function is
    /// configured for durability.
    durable_config: ?DurableConfig,

    /// The function's [environment
    /// variables](https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html). Omitted from CloudTrail logs.
    environment: ?EnvironmentResponse,

    /// The size of the function's `/tmp` directory in MB. The default value is 512,
    /// but can be any whole number between 512 and 10,240 MB. For more information,
    /// see [Configuring ephemeral storage
    /// (console)](https://docs.aws.amazon.com/lambda/latest/dg/configuration-function-common.html#configuration-ephemeral-storage).
    ephemeral_storage: ?EphemeralStorage,

    /// Connection settings for an [Amazon EFS file
    /// system](https://docs.aws.amazon.com/lambda/latest/dg/configuration-filesystem.html).
    file_system_configs: ?[]const FileSystemConfig,

    /// The function's Amazon Resource Name (ARN).
    function_arn: ?[]const u8,

    /// The name of the function.
    function_name: ?[]const u8,

    /// The function that Lambda calls to begin running your function.
    handler: ?[]const u8,

    /// The function's image configuration values.
    image_config_response: ?ImageConfigResponse,

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
    kms_key_arn: ?[]const u8,

    /// The date and time that the function was last updated, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    last_modified: ?[]const u8,

    /// The status of the last update that was performed on the function. This is
    /// first set to `Successful` after function creation completes.
    last_update_status: ?LastUpdateStatus,

    /// The reason for the last update that was performed on the function.
    last_update_status_reason: ?[]const u8,

    /// The reason code for the last update that was performed on the function.
    last_update_status_reason_code: ?LastUpdateStatusReasonCode,

    /// The function's
    /// [layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html).
    layers: ?[]const Layer,

    /// The function's Amazon CloudWatch Logs configuration settings.
    logging_config: ?LoggingConfig,

    /// For Lambda@Edge functions, the ARN of the main function.
    master_arn: ?[]const u8,

    /// The amount of memory available to the function at runtime.
    memory_size: ?i32,

    /// The type of deployment package. Set to `Image` for container image and set
    /// `Zip` for .zip file archive.
    package_type: ?PackageType,

    /// The latest updated revision of the function or alias.
    revision_id: ?[]const u8,

    /// The function's execution role.
    role: ?[]const u8,

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
    runtime: ?Runtime,

    /// The ARN of the runtime and any errors that occured.
    runtime_version_config: ?RuntimeVersionConfig,

    /// The ARN of the signing job.
    signing_job_arn: ?[]const u8,

    /// The ARN of the signing profile version.
    signing_profile_version_arn: ?[]const u8,

    /// Set `ApplyOn` to `PublishedVersions` to create a snapshot of the initialized
    /// execution environment when you publish a function version. For more
    /// information, see [Improving startup performance with Lambda
    /// SnapStart](https://docs.aws.amazon.com/lambda/latest/dg/snapstart.html).
    snap_start: ?SnapStartResponse,

    /// The current state of the function. When the state is `Inactive`, you can
    /// reactivate the function by invoking it.
    state: ?State,

    /// The reason for the function's current state.
    state_reason: ?[]const u8,

    /// The reason code for the function's current state. When the code is
    /// `Creating`, you can't invoke or modify the function.
    state_reason_code: ?StateReasonCode,

    /// The function's tenant isolation configuration settings. Determines whether
    /// the Lambda function runs on a shared or dedicated infrastructure per unique
    /// tenant.
    tenancy_config: ?TenancyConfig,

    /// The amount of time in seconds that Lambda allows a function to run before
    /// stopping it.
    timeout: ?i32,

    /// The function's X-Ray tracing configuration.
    tracing_config: ?TracingConfigResponse,

    /// The version of the Lambda function.
    version: ?[]const u8,

    /// The function's networking configuration.
    vpc_config: ?VpcConfigResponse,

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
