/// Summary information about a platform branch.
pub const PlatformBranchSummary = struct {
    /// The name of the platform branch.
    branch_name: ?[]const u8 = null,

    /// An ordinal number that designates the order in which platform branches have
    /// been added to
    /// a platform. This can be helpful, for example, if your code calls the
    /// `ListPlatformBranches` action and then displays a list of platform
    /// branches.
    ///
    /// A larger `BranchOrder` value designates a newer platform branch within the
    /// platform.
    branch_order: i32 = 0,

    /// The support life cycle state of the platform branch.
    ///
    /// Possible values: `beta` | `supported` | `deprecated` |
    /// `retired`
    lifecycle_state: ?[]const u8 = null,

    /// The name of the platform to which this platform branch belongs.
    platform_name: ?[]const u8 = null,

    /// The environment tiers that platform versions in this branch support.
    ///
    /// Possible values: `WebServer/Standard` | `Worker/SQS/HTTP`
    supported_tier_list: ?[]const []const u8 = null,
};
