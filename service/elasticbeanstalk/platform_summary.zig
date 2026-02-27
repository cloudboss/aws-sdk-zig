const PlatformStatus = @import("platform_status.zig").PlatformStatus;

/// Summary information about a platform version.
pub const PlatformSummary = struct {
    /// The operating system used by the platform version.
    operating_system_name: ?[]const u8,

    /// The version of the operating system used by the platform version.
    operating_system_version: ?[]const u8,

    /// The ARN of the platform version.
    platform_arn: ?[]const u8,

    /// The state of the platform version's branch in its lifecycle.
    ///
    /// Possible values: `beta` | `supported` | `deprecated` |
    /// `retired`
    platform_branch_lifecycle_state: ?[]const u8,

    /// The platform branch to which the platform version belongs.
    platform_branch_name: ?[]const u8,

    /// The category of platform version.
    platform_category: ?[]const u8,

    /// The state of the platform version in its lifecycle.
    ///
    /// Possible values: `recommended` | empty
    ///
    /// If an empty value is returned, the platform version is supported but isn't
    /// the recommended
    /// one for its branch.
    platform_lifecycle_state: ?[]const u8,

    /// The AWS account ID of the person who created the platform version.
    platform_owner: ?[]const u8,

    /// The status of the platform version. You can create an environment from the
    /// platform
    /// version once it is ready.
    platform_status: ?PlatformStatus,

    /// The version string of the platform version.
    platform_version: ?[]const u8,

    /// The additions associated with the platform version.
    supported_addon_list: ?[]const []const u8,

    /// The tiers in which the platform version runs.
    supported_tier_list: ?[]const []const u8,
};
