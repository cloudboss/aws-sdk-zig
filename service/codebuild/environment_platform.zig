const EnvironmentLanguage = @import("environment_language.zig").EnvironmentLanguage;
const PlatformType = @import("platform_type.zig").PlatformType;

/// A set of Docker images that are related by platform and are managed by
/// CodeBuild.
pub const EnvironmentPlatform = struct {
    /// The list of programming languages that are available for the specified
    /// platform.
    languages: ?[]const EnvironmentLanguage = null,

    /// The platform's name.
    platform: ?PlatformType = null,

    pub const json_field_names = .{
        .languages = "languages",
        .platform = "platform",
    };
};
