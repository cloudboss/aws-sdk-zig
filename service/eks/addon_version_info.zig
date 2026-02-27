const Compatibility = @import("compatibility.zig").Compatibility;

/// Information about an add-on version.
pub const AddonVersionInfo = struct {
    /// The version of the add-on.
    addon_version: ?[]const u8,

    /// The architectures that the version supports.
    architecture: ?[]const []const u8,

    /// An object representing the compatibilities of a version.
    compatibilities: ?[]const Compatibility,

    /// Indicates the compute type of the add-on version.
    compute_types: ?[]const []const u8,

    /// Whether the add-on requires configuration.
    requires_configuration: bool = false,

    /// Indicates if the add-on requires IAM Permissions to operate, such as
    /// networking
    /// permissions.
    requires_iam_permissions: bool = false,

    pub const json_field_names = .{
        .addon_version = "addonVersion",
        .architecture = "architecture",
        .compatibilities = "compatibilities",
        .compute_types = "computeTypes",
        .requires_configuration = "requiresConfiguration",
        .requires_iam_permissions = "requiresIamPermissions",
    };
};
