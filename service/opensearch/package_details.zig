const PackageConfiguration = @import("package_configuration.zig").PackageConfiguration;
const PluginProperties = @import("plugin_properties.zig").PluginProperties;
const ErrorDetails = @import("error_details.zig").ErrorDetails;
const PackageEncryptionOptions = @import("package_encryption_options.zig").PackageEncryptionOptions;
const PackageStatus = @import("package_status.zig").PackageStatus;
const PackageType = @import("package_type.zig").PackageType;
const PackageVendingOptions = @import("package_vending_options.zig").PackageVendingOptions;

/// Basic information about a package.
pub const PackageDetails = struct {
    /// A list of users who are allowed to view and associate the package. This
    /// field is only
    /// visible to the owner of a package.
    allow_listed_user_list: ?[]const []const u8 = null,

    /// This represents the available configuration parameters for the package.
    available_package_configuration: ?PackageConfiguration = null,

    /// The package version.
    available_package_version: ?[]const u8 = null,

    /// If the package is a `ZIP-PLUGIN` package, additional information about
    /// plugin properties.
    available_plugin_properties: ?PluginProperties = null,

    /// The timestamp when the package was created.
    created_at: ?i64 = null,

    /// Version of OpenSearch or Elasticsearch, in the format Elasticsearch_X.Y or
    /// OpenSearch_X.Y. Defaults to the latest version of OpenSearch.
    engine_version: ?[]const u8 = null,

    /// Additional information if the package is in an error state. Null otherwise.
    error_details: ?ErrorDetails = null,

    /// Date and time when the package was last updated.
    last_updated_at: ?i64 = null,

    /// User-specified description of the package.
    package_description: ?[]const u8 = null,

    /// Encryption options for a package.
    package_encryption_options: ?PackageEncryptionOptions = null,

    /// The unique identifier of the package.
    package_id: ?[]const u8 = null,

    /// The user-specified name of the package.
    package_name: ?[]const u8 = null,

    /// The owner of the package who is allowed to create and update a package and
    /// add users
    /// to the package scope.
    package_owner: ?[]const u8 = null,

    /// The current status of the package. The available options are `AVAILABLE`,
    /// `COPYING`, `COPY_FAILED`, `VALIDATNG`,
    /// `VALIDATION_FAILED`, `DELETING`, and
    /// `DELETE_FAILED`.
    package_status: ?PackageStatus = null,

    /// The type of package.
    package_type: ?PackageType = null,

    /// Package Vending Options for a package.
    package_vending_options: ?PackageVendingOptions = null,

    pub const json_field_names = .{
        .allow_listed_user_list = "AllowListedUserList",
        .available_package_configuration = "AvailablePackageConfiguration",
        .available_package_version = "AvailablePackageVersion",
        .available_plugin_properties = "AvailablePluginProperties",
        .created_at = "CreatedAt",
        .engine_version = "EngineVersion",
        .error_details = "ErrorDetails",
        .last_updated_at = "LastUpdatedAt",
        .package_description = "PackageDescription",
        .package_encryption_options = "PackageEncryptionOptions",
        .package_id = "PackageID",
        .package_name = "PackageName",
        .package_owner = "PackageOwner",
        .package_status = "PackageStatus",
        .package_type = "PackageType",
        .package_vending_options = "PackageVendingOptions",
    };
};
