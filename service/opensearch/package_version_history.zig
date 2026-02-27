const PackageConfiguration = @import("package_configuration.zig").PackageConfiguration;
const PluginProperties = @import("plugin_properties.zig").PluginProperties;

/// Details about a package version.
pub const PackageVersionHistory = struct {
    /// A message associated with the package version when it was uploaded.
    commit_message: ?[]const u8,

    /// The date and time when the package was created.
    created_at: ?i64,

    /// The configuration details for a specific version of a package.
    package_configuration: ?PackageConfiguration,

    /// The package version.
    package_version: ?[]const u8,

    /// Additional information about plugin properties if the package is a
    /// `ZIP-PLUGIN` package.
    plugin_properties: ?PluginProperties,

    pub const json_field_names = .{
        .commit_message = "CommitMessage",
        .created_at = "CreatedAt",
        .package_configuration = "PackageConfiguration",
        .package_version = "PackageVersion",
        .plugin_properties = "PluginProperties",
    };
};
