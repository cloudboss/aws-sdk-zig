const aws = @import("aws");

const S3Location = @import("s3_location.zig").S3Location;
const PlatformType = @import("platform_type.zig").PlatformType;

/// Describes an application in the application catalog.
pub const Application = struct {
    /// The app block ARN of the application.
    app_block_arn: ?[]const u8 = null,

    /// The ARN of the application.
    arn: ?[]const u8 = null,

    /// The time at which the application was created within the app block.
    created_time: ?i64 = null,

    /// The description of the application.
    description: ?[]const u8 = null,

    /// The application name to display.
    display_name: ?[]const u8 = null,

    /// If there is a problem, the application can be disabled after image creation.
    enabled: ?bool = null,

    /// The S3 location of the application icon.
    icon_s3_location: ?S3Location = null,

    /// The URL for the application icon. This URL might be time-limited.
    icon_url: ?[]const u8 = null,

    /// The instance families for the application.
    instance_families: ?[]const []const u8 = null,

    /// The arguments that are passed to the application at launch.
    launch_parameters: ?[]const u8 = null,

    /// The path to the application executable in the instance.
    launch_path: ?[]const u8 = null,

    /// Additional attributes that describe the application.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The name of the application.
    name: ?[]const u8 = null,

    /// The platforms on which the application can run.
    platforms: ?[]const PlatformType = null,

    /// The working directory for the application.
    working_directory: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_block_arn = "AppBlockArn",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .display_name = "DisplayName",
        .enabled = "Enabled",
        .icon_s3_location = "IconS3Location",
        .icon_url = "IconURL",
        .instance_families = "InstanceFamilies",
        .launch_parameters = "LaunchParameters",
        .launch_path = "LaunchPath",
        .metadata = "Metadata",
        .name = "Name",
        .platforms = "Platforms",
        .working_directory = "WorkingDirectory",
    };
};
