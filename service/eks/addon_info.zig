const AddonVersionInfo = @import("addon_version_info.zig").AddonVersionInfo;
const MarketplaceInformation = @import("marketplace_information.zig").MarketplaceInformation;

/// Information about an add-on.
pub const AddonInfo = struct {
    /// The name of the add-on.
    addon_name: ?[]const u8 = null,

    /// An object representing information about available add-on versions and
    /// compatible
    /// Kubernetes versions.
    addon_versions: ?[]const AddonVersionInfo = null,

    /// The default Kubernetes namespace where this addon is typically installed if
    /// no custom namespace is specified.
    default_namespace: ?[]const u8 = null,

    /// Information about the add-on from the Amazon Web Services Marketplace.
    marketplace_information: ?MarketplaceInformation = null,

    /// The owner of the add-on.
    owner: ?[]const u8 = null,

    /// The publisher of the add-on.
    publisher: ?[]const u8 = null,

    /// The type of the add-on.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .addon_name = "addonName",
        .addon_versions = "addonVersions",
        .default_namespace = "defaultNamespace",
        .marketplace_information = "marketplaceInformation",
        .owner = "owner",
        .publisher = "publisher",
        .@"type" = "type",
    };
};
