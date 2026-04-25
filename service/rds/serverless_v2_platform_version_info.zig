const ServerlessV2FeaturesSupport = @import("serverless_v2_features_support.zig").ServerlessV2FeaturesSupport;

/// This data type is used as a response element in the action
/// `DescribeServerlessV2PlatformVersions`.
pub const ServerlessV2PlatformVersionInfo = struct {
    /// The name of the database engine.
    engine: ?[]const u8 = null,

    /// Indicates whether this platform version is the default version for the
    /// engine. The default platform version is the version used for new DB
    /// clusters.
    is_default: ?bool = null,

    /// Specifies any Aurora Serverless v2 properties or limits that differ between
    /// Aurora Serverless v2 platform versions. You can retrieve the platform
    /// version of an existing DB cluster and check whether that version supports
    /// certain Aurora Serverless v2 features before you attempt to use those
    /// features.
    serverless_v2_features_support: ?ServerlessV2FeaturesSupport = null,

    /// The version number of the serverless platform.
    serverless_v2_platform_version: ?[]const u8 = null,

    /// The description of the serverless platform.
    serverless_v2_platform_version_description: ?[]const u8 = null,

    /// The status of the serverless platform. Valid statuses are the following:
    ///
    /// * `enabled` - The platform version is in use.
    /// * `disabled` - The platform version is not in use.
    status: ?[]const u8 = null,
};
