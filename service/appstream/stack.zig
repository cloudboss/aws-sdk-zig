const AccessEndpoint = @import("access_endpoint.zig").AccessEndpoint;
const ApplicationSettingsResponse = @import("application_settings_response.zig").ApplicationSettingsResponse;
const StackError = @import("stack_error.zig").StackError;
const StorageConnector = @import("storage_connector.zig").StorageConnector;
const StreamingExperienceSettings = @import("streaming_experience_settings.zig").StreamingExperienceSettings;
const UserSetting = @import("user_setting.zig").UserSetting;

/// Describes a stack.
pub const Stack = struct {
    /// The list of virtual private cloud (VPC) interface endpoint objects. Users of
    /// the stack can connect to WorkSpaces Applications only through the specified
    /// endpoints.
    access_endpoints: ?[]const AccessEndpoint,

    /// The persistent application settings for users of the stack.
    application_settings: ?ApplicationSettingsResponse,

    /// The ARN of the stack.
    arn: ?[]const u8,

    /// The time the stack was created.
    created_time: ?i64,

    /// The description to display.
    description: ?[]const u8,

    /// The stack name to display.
    display_name: ?[]const u8,

    /// The domains where WorkSpaces Applications streaming sessions can be embedded
    /// in an iframe. You must approve the domains that you want to host embedded
    /// WorkSpaces Applications streaming sessions.
    embed_host_domains: ?[]const []const u8,

    /// The URL that users are redirected to after they click the Send Feedback
    /// link. If no URL is specified, no Send Feedback link is displayed.
    feedback_url: ?[]const u8,

    /// The name of the stack.
    name: []const u8,

    /// The URL that users are redirected to after their streaming session ends.
    redirect_url: ?[]const u8,

    /// The errors for the stack.
    stack_errors: ?[]const StackError,

    /// The storage connectors to enable.
    storage_connectors: ?[]const StorageConnector,

    /// The streaming protocol you want your stack to prefer. This can be UDP or
    /// TCP. Currently, UDP is only supported in the Windows native client.
    streaming_experience_settings: ?StreamingExperienceSettings,

    /// The actions that are enabled or disabled for users during their streaming
    /// sessions. By default these actions are enabled.
    user_settings: ?[]const UserSetting,

    pub const json_field_names = .{
        .access_endpoints = "AccessEndpoints",
        .application_settings = "ApplicationSettings",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .display_name = "DisplayName",
        .embed_host_domains = "EmbedHostDomains",
        .feedback_url = "FeedbackURL",
        .name = "Name",
        .redirect_url = "RedirectURL",
        .stack_errors = "StackErrors",
        .storage_connectors = "StorageConnectors",
        .streaming_experience_settings = "StreamingExperienceSettings",
        .user_settings = "UserSettings",
    };
};
