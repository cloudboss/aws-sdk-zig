const CustomAmi = @import("custom_ami.zig").CustomAmi;
const PlatformFramework = @import("platform_framework.zig").PlatformFramework;
const PlatformStatus = @import("platform_status.zig").PlatformStatus;
const PlatformProgrammingLanguage = @import("platform_programming_language.zig").PlatformProgrammingLanguage;

/// Detailed information about a platform version.
pub const PlatformDescription = struct {
    /// The custom AMIs supported by the platform version.
    custom_ami_list: ?[]const CustomAmi = null,

    /// The date when the platform version was created.
    date_created: ?i64 = null,

    /// The date when the platform version was last updated.
    date_updated: ?i64 = null,

    /// The description of the platform version.
    description: ?[]const u8 = null,

    /// The frameworks supported by the platform version.
    frameworks: ?[]const PlatformFramework = null,

    /// Information about the maintainer of the platform version.
    maintainer: ?[]const u8 = null,

    /// The operating system used by the platform version.
    operating_system_name: ?[]const u8 = null,

    /// The version of the operating system used by the platform version.
    operating_system_version: ?[]const u8 = null,

    /// The ARN of the platform version.
    platform_arn: ?[]const u8 = null,

    /// The state of the platform version's branch in its lifecycle.
    ///
    /// Possible values: `Beta` | `Supported` | `Deprecated` |
    /// `Retired`
    platform_branch_lifecycle_state: ?[]const u8 = null,

    /// The platform branch to which the platform version belongs.
    platform_branch_name: ?[]const u8 = null,

    /// The category of the platform version.
    platform_category: ?[]const u8 = null,

    /// The state of the platform version in its lifecycle.
    ///
    /// Possible values: `Recommended` | `null`
    ///
    /// If a null value is returned, the platform version isn't the recommended one
    /// for its
    /// branch. Each platform branch has a single recommended platform version,
    /// typically the most
    /// recent one.
    platform_lifecycle_state: ?[]const u8 = null,

    /// The name of the platform version.
    platform_name: ?[]const u8 = null,

    /// The AWS account ID of the person who created the platform version.
    platform_owner: ?[]const u8 = null,

    /// The status of the platform version.
    platform_status: ?PlatformStatus = null,

    /// The version of the platform version.
    platform_version: ?[]const u8 = null,

    /// The programming languages supported by the platform version.
    programming_languages: ?[]const PlatformProgrammingLanguage = null,

    /// The name of the solution stack used by the platform version.
    solution_stack_name: ?[]const u8 = null,

    /// The additions supported by the platform version.
    supported_addon_list: ?[]const []const u8 = null,

    /// The tiers supported by the platform version.
    supported_tier_list: ?[]const []const u8 = null,
};
