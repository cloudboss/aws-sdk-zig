const ScreenImageFormat = @import("screen_image_format.zig").ScreenImageFormat;
const ScreenResolution = @import("screen_resolution.zig").ScreenResolution;
const AgentAccessSetting = @import("agent_access_setting.zig").AgentAccessSetting;
const UserControlMode = @import("user_control_mode.zig").UserControlMode;

/// The configuration for agent access on a stack. Agent access enables AI
/// agents to interact with desktop applications during streaming sessions.
pub const AgentAccessConfig = struct {
    /// The Amazon Resource Name (ARN) of the Amazon S3 bucket where agent
    /// screenshots are stored. Required when ScreenshotsUploadEnabled is true.
    s3_bucket_arn: ?[]const u8 = null,

    /// The image format for agent screen captures.
    screen_image_format: ScreenImageFormat,

    /// The screen resolution for the agent streaming environment.
    screen_resolution: ScreenResolution,

    /// Indicates whether screenshot uploads to Amazon S3 are enabled for agent
    /// sessions.
    screenshots_upload_enabled: ?bool = null,

    /// The list of agent access settings that define permissions for each agent
    /// action. You must specify at least one setting.
    settings: []const AgentAccessSetting,

    /// The user control mode for agent sessions. This setting determines how users
    /// can interact with agent sessions.
    user_control_mode: ?UserControlMode = null,

    pub const json_field_names = .{
        .s3_bucket_arn = "S3BucketArn",
        .screen_image_format = "ScreenImageFormat",
        .screen_resolution = "ScreenResolution",
        .screenshots_upload_enabled = "ScreenshotsUploadEnabled",
        .settings = "Settings",
        .user_control_mode = "UserControlMode",
    };
};
