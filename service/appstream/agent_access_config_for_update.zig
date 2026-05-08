const ScreenImageFormat = @import("screen_image_format.zig").ScreenImageFormat;
const ScreenResolution = @import("screen_resolution.zig").ScreenResolution;
const AgentAccessSetting = @import("agent_access_setting.zig").AgentAccessSetting;

/// The configuration for updating agent access on a stack. This type supports
/// partial updates, so you only need to specify the fields you want to change.
pub const AgentAccessConfigForUpdate = struct {
    /// The Amazon Resource Name (ARN) of the Amazon S3 bucket where agent
    /// screenshots are stored.
    s3_bucket_arn: ?[]const u8 = null,

    /// The image format for agent screen captures.
    screen_image_format: ?ScreenImageFormat = null,

    /// The screen resolution for the agent streaming environment.
    screen_resolution: ?ScreenResolution = null,

    /// Indicates whether screenshot uploads to Amazon S3 are enabled for agent
    /// sessions.
    screenshots_upload_enabled: ?bool = null,

    /// The list of agent access settings that define permissions for each agent
    /// action.
    settings: ?[]const AgentAccessSetting = null,

    pub const json_field_names = .{
        .s3_bucket_arn = "S3BucketArn",
        .screen_image_format = "ScreenImageFormat",
        .screen_resolution = "ScreenResolution",
        .screenshots_upload_enabled = "ScreenshotsUploadEnabled",
        .settings = "Settings",
    };
};
