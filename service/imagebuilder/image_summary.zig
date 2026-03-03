const aws = @import("aws");

const BuildType = @import("build_type.zig").BuildType;
const ImageSource = @import("image_source.zig").ImageSource;
const ImageLoggingConfiguration = @import("image_logging_configuration.zig").ImageLoggingConfiguration;
const OutputResources = @import("output_resources.zig").OutputResources;
const Platform = @import("platform.zig").Platform;
const ImageState = @import("image_state.zig").ImageState;
const ImageType = @import("image_type.zig").ImageType;

/// An image summary.
pub const ImageSummary = struct {
    /// The Amazon Resource Name (ARN) of the image.
    arn: ?[]const u8 = null,

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
    build_type: ?BuildType = null,

    /// The date on which Image Builder created this image.
    date_created: ?[]const u8 = null,

    /// The time when deprecation occurs for an image resource. This can be a past
    /// or future date.
    deprecation_time: ?i64 = null,

    /// The origin of the base image that Image Builder used to build this image.
    image_source: ?ImageSource = null,

    /// Identifies the last runtime instance of the lifecycle policy to take action
    /// on the image.
    lifecycle_execution_id: ?[]const u8 = null,

    /// The logging configuration that's defined for the image.
    logging_configuration: ?ImageLoggingConfiguration = null,

    /// The name of the image.
    name: ?[]const u8 = null,

    /// The operating system version of the instances that launch from this image.
    /// For
    /// example, Amazon Linux 2, Ubuntu 18, or Microsoft Windows Server 2019.
    os_version: ?[]const u8 = null,

    /// The output resources that Image Builder produced when it created this image.
    output_resources: ?OutputResources = null,

    /// The owner of the image.
    owner: ?[]const u8 = null,

    /// The image operating system platform, such as Linux or Windows.
    platform: ?Platform = null,

    /// The state of the image.
    state: ?ImageState = null,

    /// The tags that apply to this image.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies whether this image produces an AMI or a container image.
    @"type": ?ImageType = null,

    /// The version of the image.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .build_type = "buildType",
        .date_created = "dateCreated",
        .deprecation_time = "deprecationTime",
        .image_source = "imageSource",
        .lifecycle_execution_id = "lifecycleExecutionId",
        .logging_configuration = "loggingConfiguration",
        .name = "name",
        .os_version = "osVersion",
        .output_resources = "outputResources",
        .owner = "owner",
        .platform = "platform",
        .state = "state",
        .tags = "tags",
        .@"type" = "type",
        .version = "version",
    };
};
