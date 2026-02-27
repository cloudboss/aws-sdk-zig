const aws = @import("aws");

const ImageScanningConfiguration = @import("image_scanning_configuration.zig").ImageScanningConfiguration;
const ImageTestsConfiguration = @import("image_tests_configuration.zig").ImageTestsConfiguration;
const ImageStatus = @import("image_status.zig").ImageStatus;
const PipelineLoggingConfiguration = @import("pipeline_logging_configuration.zig").PipelineLoggingConfiguration;
const Platform = @import("platform.zig").Platform;
const Schedule = @import("schedule.zig").Schedule;
const PipelineStatus = @import("pipeline_status.zig").PipelineStatus;
const WorkflowConfiguration = @import("workflow_configuration.zig").WorkflowConfiguration;

/// Details of an image pipeline.
pub const ImagePipeline = struct {
    /// The Amazon Resource Name (ARN) of the image pipeline.
    arn: ?[]const u8,

    /// Image Builder tracks the number of consecutive failures for scheduled
    /// pipeline
    /// executions and takes one of the following actions each time it runs on a
    /// schedule:
    ///
    /// * If the pipeline execution is successful, the number of consecutive
    /// failures resets to zero.
    ///
    /// * If the pipeline execution fails, Image Builder increments the number of
    /// consecutive failures. If the failure count exceeds the limit defined in the
    /// `AutoDisablePolicy`, Image Builder disables the pipeline.
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
    consecutive_failures: ?i32,

    /// The Amazon Resource Name (ARN) of the container recipe that is used for this
    /// pipeline.
    container_recipe_arn: ?[]const u8,

    /// The date on which this image pipeline was created.
    date_created: ?[]const u8,

    /// This is no longer supported, and does not return a value.
    date_last_run: ?[]const u8,

    /// The next date when the pipeline is scheduled to run.
    date_next_run: ?[]const u8,

    /// The date on which this image pipeline was last updated.
    date_updated: ?[]const u8,

    /// The description of the image pipeline.
    description: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the distribution configuration associated
    /// with this
    /// image pipeline.
    distribution_configuration_arn: ?[]const u8,

    /// Collects additional information about the image being created, including the
    /// operating
    /// system (OS) version and package list. This information is used to enhance
    /// the overall
    /// experience of using EC2 Image Builder. Enabled by default.
    enhanced_image_metadata_enabled: ?bool,

    /// The name or Amazon Resource Name (ARN) for the IAM role you create that
    /// grants
    /// Image Builder access to perform workflow actions.
    execution_role: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the image recipe associated with this
    /// image
    /// pipeline.
    image_recipe_arn: ?[]const u8,

    /// Contains settings for vulnerability scans.
    image_scanning_configuration: ?ImageScanningConfiguration,

    /// The image tests configuration of the image pipeline.
    image_tests_configuration: ?ImageTestsConfiguration,

    /// The Amazon Resource Name (ARN) of the infrastructure configuration
    /// associated with
    /// this image pipeline.
    infrastructure_configuration_arn: ?[]const u8,

    /// The status of the last image that this pipeline built, such as
    /// `BUILDING`, `TESTING`, `FAILED`,
    /// or `AVAILABLE`.
    last_run_status: ?ImageStatus,

    /// Defines logging configuration for the output image.
    logging_configuration: ?PipelineLoggingConfiguration,

    /// The name of the image pipeline.
    name: ?[]const u8,

    /// The platform of the image pipeline.
    platform: ?Platform,

    /// The schedule of the image pipeline.
    schedule: ?Schedule,

    /// The status of the image pipeline.
    status: ?PipelineStatus,

    /// The tags of this image pipeline.
    tags: ?[]const aws.map.StringMapEntry,

    /// Contains the workflows that run for the image pipeline.
    workflows: ?[]const WorkflowConfiguration,

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
