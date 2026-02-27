const ReleaseStatusValues = @import("release_status_values.zig").ReleaseStatusValues;

/// Provides information about a replication instance version.
pub const EngineVersion = struct {
    /// The date when the replication instance will be automatically upgraded. This
    /// setting only
    /// applies if the `auto-minor-version` setting is enabled.
    auto_upgrade_date: ?i64,

    /// The list of valid replication instance versions that you can upgrade to.
    available_upgrades: ?[]const []const u8,

    /// The date when the replication instance version will be deprecated and can no
    /// longer be
    /// requested.
    deprecation_date: ?i64,

    /// The date when the replication instance will have a version upgrade forced.
    force_upgrade_date: ?i64,

    /// The date when the replication instance version became publicly available.
    launch_date: ?i64,

    /// The lifecycle status of the replication instance version. Valid values are
    /// `DEPRECATED`, `DEFAULT_VERSION`, and `ACTIVE`.
    lifecycle: ?[]const u8,

    /// The release status of the replication instance version.
    release_status: ?ReleaseStatusValues,

    /// The version number of the replication instance.
    version: ?[]const u8,

    pub const json_field_names = .{
        .auto_upgrade_date = "AutoUpgradeDate",
        .available_upgrades = "AvailableUpgrades",
        .deprecation_date = "DeprecationDate",
        .force_upgrade_date = "ForceUpgradeDate",
        .launch_date = "LaunchDate",
        .lifecycle = "Lifecycle",
        .release_status = "ReleaseStatus",
        .version = "Version",
    };
};
