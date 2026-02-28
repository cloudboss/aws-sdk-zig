const aws = @import("aws");

const BuildType = @import("build_type.zig").BuildType;
const ContainerRecipe = @import("container_recipe.zig").ContainerRecipe;
const DistributionConfiguration = @import("distribution_configuration.zig").DistributionConfiguration;
const ImageRecipe = @import("image_recipe.zig").ImageRecipe;
const ImageScanningConfiguration = @import("image_scanning_configuration.zig").ImageScanningConfiguration;
const ImageSource = @import("image_source.zig").ImageSource;
const ImageTestsConfiguration = @import("image_tests_configuration.zig").ImageTestsConfiguration;
const InfrastructureConfiguration = @import("infrastructure_configuration.zig").InfrastructureConfiguration;
const ImageLoggingConfiguration = @import("image_logging_configuration.zig").ImageLoggingConfiguration;
const OutputResources = @import("output_resources.zig").OutputResources;
const Platform = @import("platform.zig").Platform;
const ImageScanState = @import("image_scan_state.zig").ImageScanState;
const ImageState = @import("image_state.zig").ImageState;
const ImageType = @import("image_type.zig").ImageType;
const WorkflowConfiguration = @import("workflow_configuration.zig").WorkflowConfiguration;

/// An Image Builder image resource that keeps track of all of the settings used
/// to create, configure,
/// and distribute output for that image. You must specify exactly one recipe
/// for the image –
/// either a container recipe (`containerRecipe`), which creates a container
/// image, or an
/// image recipe (`imageRecipe`), which creates an AMI.
pub const Image = struct {
    /// The Amazon Resource Name (ARN) of the image.
    ///
    /// Semantic versioning is included in each object's Amazon Resource Name (ARN),
    /// at the level that applies to that object as follows:
    ///
    /// * Versionless ARNs and Name ARNs do not include specific values in any of
    ///   the nodes. The nodes are
    /// either left off entirely, or they are specified as wildcards, for example:
    /// x.x.x.
    ///
    /// * Version ARNs have only the first three nodes: ..
    ///
    /// * Build version ARNs have all four nodes, and point to a specific build for
    ///   a specific version of an object.
    arn: ?[]const u8,

    /// Indicates the type of build that created this image. The build can be
    /// initiated in the
    /// following ways:
    ///
    /// * **USER_INITIATED** – A manual
    /// pipeline build request.
    ///
    /// * **SCHEDULED** – A pipeline build
    /// initiated by a cron expression in the Image Builder pipeline, or from
    /// EventBridge.
    ///
    /// * **IMPORT** – A VM import created
    /// the image to use as the base image for the recipe.
    ///
    /// * **IMPORT_ISO** – An ISO disk import created
    /// the image.
    build_type: ?BuildType,

    /// For container images, this is the container recipe that Image Builder used
    /// to create the
    /// image. For images that distribute an AMI, this is empty.
    container_recipe: ?ContainerRecipe,

    /// The date on which Image Builder created this image.
    date_created: ?[]const u8,

    /// The time when deprecation occurs for an image resource. This can be a past
    /// or future date.
    deprecation_time: ?i64,

    /// The distribution configuration that Image Builder used to create this image.
    distribution_configuration: ?DistributionConfiguration,

    /// Indicates whether Image Builder collects additional information about the
    /// image, such as
    /// the operating system (OS) version and package list.
    enhanced_image_metadata_enabled: ?bool,

    /// The name or Amazon Resource Name (ARN) for the IAM role you create that
    /// grants
    /// Image Builder access to perform workflow actions.
    execution_role: ?[]const u8,

    /// For images that distribute an AMI, this is the image recipe that Image
    /// Builder used to
    /// create the image. For container images, this is empty.
    image_recipe: ?ImageRecipe,

    /// Contains settings for vulnerability scans.
    image_scanning_configuration: ?ImageScanningConfiguration,

    /// The origin of the base image that Image Builder used to build this image.
    image_source: ?ImageSource,

    /// The image tests that ran when that Image Builder created this image.
    image_tests_configuration: ?ImageTestsConfiguration,

    /// The infrastructure that Image Builder used to create this image.
    infrastructure_configuration: ?InfrastructureConfiguration,

    /// Identifies the last runtime instance of the lifecycle policy to take action
    /// on the image.
    lifecycle_execution_id: ?[]const u8,

    /// The logging configuration that's defined for the image. Image Builder uses
    /// the defined settings
    /// to direct execution log output during image creation.
    logging_configuration: ?ImageLoggingConfiguration,

    /// The name of the image.
    name: ?[]const u8,

    /// The operating system version for instances that launch from this image. For
    /// example,
    /// Amazon Linux 2, Ubuntu 18, or Microsoft Windows Server 2019.
    os_version: ?[]const u8,

    /// The output resources that Image Builder produces for this image.
    output_resources: ?OutputResources,

    /// The image operating system platform, such as Linux or Windows.
    platform: ?Platform,

    /// Contains information about the current state of scans for this image.
    scan_state: ?ImageScanState,

    /// The Amazon Resource Name (ARN) of the image pipeline that created this
    /// image.
    source_pipeline_arn: ?[]const u8,

    /// The name of the image pipeline that created this image.
    source_pipeline_name: ?[]const u8,

    /// The state of the image.
    state: ?ImageState,

    /// The tags that apply to this image.
    tags: ?[]const aws.map.StringMapEntry,

    /// Specifies whether this image produces an AMI or a container image.
    @"type": ?ImageType,

    /// The semantic version of the image.
    ///
    /// The semantic version has four nodes: ../.
    /// You can assign values for the first three, and can filter on all of them.
    ///
    /// **Assignment:** For the first three nodes you can assign any positive
    /// integer value, including
    /// zero, with an upper limit of 2^30-1, or 1073741823 for each node. Image
    /// Builder automatically assigns the
    /// build number to the fourth node.
    ///
    /// **Patterns:** You can use any numeric pattern that adheres to the assignment
    /// requirements for
    /// the nodes that you can assign. For example, you might choose a software
    /// version pattern, such as 1.0.0, or
    /// a date, such as 2021.01.01.
    ///
    /// **Filtering:** With semantic versioning, you have the flexibility to use
    /// wildcards (x)
    /// to specify the most recent versions or nodes when selecting the base image
    /// or components for your
    /// recipe. When you use a wildcard in any node, all nodes to the right of the
    /// first wildcard must also be
    /// wildcards.
    version: ?[]const u8,

    /// Contains the build and test workflows that are associated with the image.
    workflows: ?[]const WorkflowConfiguration,

    pub const json_field_names = .{
        .arn = "arn",
        .build_type = "buildType",
        .container_recipe = "containerRecipe",
        .date_created = "dateCreated",
        .deprecation_time = "deprecationTime",
        .distribution_configuration = "distributionConfiguration",
        .enhanced_image_metadata_enabled = "enhancedImageMetadataEnabled",
        .execution_role = "executionRole",
        .image_recipe = "imageRecipe",
        .image_scanning_configuration = "imageScanningConfiguration",
        .image_source = "imageSource",
        .image_tests_configuration = "imageTestsConfiguration",
        .infrastructure_configuration = "infrastructureConfiguration",
        .lifecycle_execution_id = "lifecycleExecutionId",
        .logging_configuration = "loggingConfiguration",
        .name = "name",
        .os_version = "osVersion",
        .output_resources = "outputResources",
        .platform = "platform",
        .scan_state = "scanState",
        .source_pipeline_arn = "sourcePipelineArn",
        .source_pipeline_name = "sourcePipelineName",
        .state = "state",
        .tags = "tags",
        .@"type" = "type",
        .version = "version",
        .workflows = "workflows",
    };
};
