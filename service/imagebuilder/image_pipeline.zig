const aws = @import("aws");

const ImageScanningConfiguration = @import("image_scanning_configuration.zig").ImageScanningConfiguration;
const ImageTestsConfiguration = @import("image_tests_configuration.zig").ImageTestsConfiguration;
const ImageStatus = @import("image_status.zig").ImageStatus;
const PipelineLoggingConfiguration = @import("pipeline_logging_configuration.zig").PipelineLoggingConfiguration;
const Platform = @import("platform.zig").Platform;
const Schedule = @import("schedule.zig").Schedule;
const PipelineStatus = @import("pipeline_status.zig").PipelineStatus;
const WorkflowConfiguration = @import("workflow_configuration.zig").WorkflowConfiguration;

/// Defines the automation configuration for building, testing, and
/// distributing images. A pipeline references the resources that its builds
/// use, such as the recipe and infrastructure configuration. It also holds
/// the settings that control its builds, such as the schedule and custom
/// workflows.
pub const ImagePipeline = struct {
    /// The Amazon Resource Name (ARN) of the image pipeline.
    arn: ?[]const u8 = null,

    /// Image Builder tracks the number of consecutive failures for scheduled
    /// pipeline
    /// executions and takes one of the following actions each time it runs on a
    /// schedule:
    ///
    /// * If the pipeline execution is successful, the number of consecutive
    /// failures resets to zero.
    ///
    /// * If the pipeline execution fails, Image Builder increments the number of
    /// consecutive failures. If the failure count reaches the limit defined in the
    /// AutoDisablePolicy, Image Builder disables the pipeline.
    ///
    /// The consecutive failure count is also reset to zero under the following
    /// conditions:
    ///
    /// * The pipeline runs manually and succeeds.
    ///
    /// * The pipeline configuration is updated.
    ///
    /// If the pipeline runs manually and fails, the count remains the same. The
    /// next
    /// scheduled run continues to increment where it left off before.
    consecutive_failures: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the container recipe that is used for this
    /// pipeline.
    container_recipe_arn: ?[]const u8 = null,

    /// The date on which this image pipeline was created.
    date_created: ?[]const u8 = null,

    /// The date on which this image pipeline was last run.
    date_last_run: ?[]const u8 = null,

    /// The next date when the pipeline is scheduled to run.
    date_next_run: ?[]const u8 = null,

    /// The date on which this image pipeline was last updated.
    date_updated: ?[]const u8 = null,

    /// The description of the image pipeline.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the distribution configuration associated
    /// with this
    /// image pipeline.
    distribution_configuration_arn: ?[]const u8 = null,

    /// Specifies whether to collect additional information about the image being
    /// created, including the operating
    /// system (OS) version and package list. Defaults to `true`.
    enhanced_image_metadata_enabled: ?bool = null,

    /// The name or Amazon Resource Name (ARN) for the IAM role you create that
    /// grants
    /// Image Builder access to perform workflow actions.
    execution_role: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the image recipe associated with this
    /// image
    /// pipeline.
    image_recipe_arn: ?[]const u8 = null,

    /// Contains settings for vulnerability scans that Amazon Inspector runs against
    /// the test instance
    /// during image creation.
    image_scanning_configuration: ?ImageScanningConfiguration = null,

    /// The tags that Image Builder applies to the Image Builder image resource that
    /// this
    /// pipeline's scheduled executions create. These tags don't apply to the
    /// output AMI. Builds that you start manually use the tags from the
    /// [StartImagePipelineExecution](https://docs.aws.amazon.com/imagebuilder/latest/APIReference/API_StartImagePipelineExecution.html) request instead.
    image_tags: ?[]const aws.map.StringMapEntry = null,

    /// The image tests configuration of the image pipeline.
    image_tests_configuration: ?ImageTestsConfiguration = null,

    /// The Amazon Resource Name (ARN) of the infrastructure configuration
    /// associated with
    /// this image pipeline.
    infrastructure_configuration_arn: ?[]const u8 = null,

    /// The status of the last image that this pipeline built, such as
    /// `BUILDING`, `TESTING`, `FAILED`,
    /// or `AVAILABLE`.
    last_run_status: ?ImageStatus = null,

    /// The CloudWatch Logs configuration for the pipeline: the log group for
    /// image build logs and the log group for pipeline execution logs.
    logging_configuration: ?PipelineLoggingConfiguration = null,

    /// The name of the image pipeline.
    name: ?[]const u8 = null,

    /// The platform of the image pipeline, inherited from the recipe that the
    /// pipeline uses.
    platform: ?Platform = null,

    /// The schedule of the image pipeline.
    schedule: ?Schedule = null,

    /// The status of the image pipeline. A disabled pipeline doesn't run on its
    /// schedule, but you can still start builds manually. Image Builder can also
    /// disable a
    /// pipeline automatically when consecutive scheduled builds fail.
    status: ?PipelineStatus = null,

    /// The tags of this image pipeline.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Contains the workflows that run for the image pipeline.
    workflows: ?[]const WorkflowConfiguration = null,

    pub const json_field_names = .{
        .arn = "arn",
        .consecutive_failures = "consecutiveFailures",
        .container_recipe_arn = "containerRecipeArn",
        .date_created = "dateCreated",
        .date_last_run = "dateLastRun",
        .date_next_run = "dateNextRun",
        .date_updated = "dateUpdated",
        .description = "description",
        .distribution_configuration_arn = "distributionConfigurationArn",
        .enhanced_image_metadata_enabled = "enhancedImageMetadataEnabled",
        .execution_role = "executionRole",
        .image_recipe_arn = "imageRecipeArn",
        .image_scanning_configuration = "imageScanningConfiguration",
        .image_tags = "imageTags",
        .image_tests_configuration = "imageTestsConfiguration",
        .infrastructure_configuration_arn = "infrastructureConfigurationArn",
        .last_run_status = "lastRunStatus",
        .logging_configuration = "loggingConfiguration",
        .name = "name",
        .platform = "platform",
        .schedule = "schedule",
        .status = "status",
        .tags = "tags",
        .workflows = "workflows",
    };
};
