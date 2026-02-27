const aws = @import("aws");

const ArtifactConfigOutput = @import("artifact_config_output.zig").ArtifactConfigOutput;
const BrowserConfig = @import("browser_config.zig").BrowserConfig;
const CanaryCodeOutput = @import("canary_code_output.zig").CanaryCodeOutput;
const DryRunConfigOutput = @import("dry_run_config_output.zig").DryRunConfigOutput;
const EngineConfig = @import("engine_config.zig").EngineConfig;
const ProvisionedResourceCleanupSetting = @import("provisioned_resource_cleanup_setting.zig").ProvisionedResourceCleanupSetting;
const CanaryRunConfigOutput = @import("canary_run_config_output.zig").CanaryRunConfigOutput;
const CanaryScheduleOutput = @import("canary_schedule_output.zig").CanaryScheduleOutput;
const CanaryStatus = @import("canary_status.zig").CanaryStatus;
const CanaryTimeline = @import("canary_timeline.zig").CanaryTimeline;
const VisualReferenceOutput = @import("visual_reference_output.zig").VisualReferenceOutput;
const VpcConfigOutput = @import("vpc_config_output.zig").VpcConfigOutput;

/// This structure contains all information about one canary in your account.
pub const Canary = struct {
    /// A structure that contains the configuration for canary artifacts, including
    /// the encryption-at-rest settings for artifacts that the canary uploads to
    /// Amazon S3.
    artifact_config: ?ArtifactConfigOutput,

    /// The location in Amazon S3 where Synthetics stores artifacts from the runs of
    /// this
    /// canary. Artifacts include the log file, screenshots, and HAR files.
    artifact_s3_location: ?[]const u8,

    /// A structure that specifies the browser type to use for a canary run.
    /// CloudWatch Synthetics supports running canaries on both `CHROME` and
    /// `FIREFOX` browsers.
    ///
    /// If not specified, `browserConfigs` defaults to Chrome.
    browser_configs: ?[]const BrowserConfig,

    code: ?CanaryCodeOutput,

    /// Returns the dry run configurations for a canary.
    dry_run_config: ?DryRunConfigOutput,

    /// The ARN of the Lambda function that is used as your canary's engine. For
    /// more information
    /// about Lambda ARN format, see [Resources and Conditions for Lambda
    /// Actions](https://docs.aws.amazon.com/lambda/latest/dg/lambda-api-permissions-ref.html).
    engine_arn: ?[]const u8,

    /// A list of engine configurations for the canary, one for each browser type
    /// that the canary is configured to run on.
    ///
    /// All runtime versions `syn-nodejs-puppeteer-11.0` and above, and
    /// `syn-nodejs-playwright-3.0` and above, use `engineConfigs` only.
    /// You can no longer use `engineArn` in these versions.
    ///
    /// Runtime versions older than `syn-nodejs-puppeteer-11.0` and
    /// `syn-nodejs-playwright-3.0` continue to support `engineArn` to ensure
    /// backward compatibility.
    engine_configs: ?[]const EngineConfig,

    /// The ARN of the IAM role used to run the canary. This role must include
    /// `lambda.amazonaws.com` as a principal in the trust
    /// policy.
    execution_role_arn: ?[]const u8,

    /// The number of days to retain data about failed runs of this canary.
    ///
    /// This setting affects the range of information returned by
    /// [GetCanaryRuns](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_GetCanaryRuns.html), as well as
    /// the range of information displayed in the Synthetics console.
    failure_retention_period_in_days: ?i32,

    /// The unique ID of this canary.
    id: ?[]const u8,

    /// The name of the canary.
    name: ?[]const u8,

    /// Specifies whether to also delete the Lambda functions and layers used by
    /// this canary
    /// when the canary is deleted. If it is `AUTOMATIC`, the Lambda functions and
    /// layers will be deleted
    /// when the canary is deleted.
    ///
    /// If the value of this parameter is `OFF`, then the value of the
    /// `DeleteLambda` parameter
    /// of the
    /// [DeleteCanary](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_DeleteCanary.html) operation
    /// determines whether the Lambda functions and layers will be deleted.
    provisioned_resource_cleanup: ?ProvisionedResourceCleanupSetting,

    run_config: ?CanaryRunConfigOutput,

    /// Specifies the runtime version to use for the canary. For more information
    /// about
    /// runtime versions, see [
    /// Canary Runtime
    /// Versions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_Library.html).
    runtime_version: ?[]const u8,

    /// A structure that contains information about how often the canary is to run,
    /// and when
    /// these runs are to stop.
    schedule: ?CanaryScheduleOutput,

    /// A structure that contains information about the canary's status.
    status: ?CanaryStatus,

    /// The number of days to retain data about successful runs of this canary.
    ///
    /// This setting affects the range of information returned by
    /// [GetCanaryRuns](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_GetCanaryRuns.html), as well as
    /// the range of information displayed in the Synthetics console.
    success_retention_period_in_days: ?i32,

    /// The list of key-value pairs that are associated with the canary.
    tags: ?[]const aws.map.StringMapEntry,

    /// A structure that contains information about when the canary was created,
    /// modified, and
    /// most recently run.
    timeline: ?CanaryTimeline,

    /// If this canary performs visual monitoring by comparing screenshots, this
    /// structure contains the ID of the canary run to use as the baseline for
    /// screenshots, and the coordinates
    /// of any parts of the screen to ignore during the visual monitoring
    /// comparison.
    visual_reference: ?VisualReferenceOutput,

    /// A list of visual reference configurations for the canary, one for each
    /// browser type that the canary is configured to run on. Visual references are
    /// used for visual monitoring comparisons.
    ///
    /// `syn-nodejs-puppeteer-11.0` and above, and `syn-nodejs-playwright-3.0` and
    /// above, only supports `visualReferences`. `visualReference` field is not
    /// supported.
    ///
    /// Versions older than `syn-nodejs-puppeteer-11.0` supports both
    /// `visualReference` and `visualReferences` for backward compatibility. It is
    /// recommended to use `visualReferences`
    /// for consistency and future compatibility.
    visual_references: ?[]const VisualReferenceOutput,

    vpc_config: ?VpcConfigOutput,

    pub const json_field_names = .{
        .artifact_config = "ArtifactConfig",
        .artifact_s3_location = "ArtifactS3Location",
        .browser_configs = "BrowserConfigs",
        .code = "Code",
        .dry_run_config = "DryRunConfig",
        .engine_arn = "EngineArn",
        .engine_configs = "EngineConfigs",
        .execution_role_arn = "ExecutionRoleArn",
        .failure_retention_period_in_days = "FailureRetentionPeriodInDays",
        .id = "Id",
        .name = "Name",
        .provisioned_resource_cleanup = "ProvisionedResourceCleanup",
        .run_config = "RunConfig",
        .runtime_version = "RuntimeVersion",
        .schedule = "Schedule",
        .status = "Status",
        .success_retention_period_in_days = "SuccessRetentionPeriodInDays",
        .tags = "Tags",
        .timeline = "Timeline",
        .visual_reference = "VisualReference",
        .visual_references = "VisualReferences",
        .vpc_config = "VpcConfig",
    };
};
