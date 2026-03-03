const ErrorDetails = @import("error_details.zig").ErrorDetails;
const PackageStatus = @import("package_status.zig").PackageStatus;
const PackageType = @import("package_type.zig").PackageType;

/// Basic information about a package.
pub const PackageDetails = struct {
    available_package_version: ?[]const u8 = null,

    /// Timestamp which tells creation date of the package.
    created_at: ?i64 = null,

    /// Additional information if the package is in an error state. Null otherwise.
    error_details: ?ErrorDetails = null,

    last_updated_at: ?i64 = null,

    /// User-specified description of the package.
    package_description: ?[]const u8 = null,

    /// Internal ID of the package.
    package_id: ?[]const u8 = null,

    /// User specified name of the package.
    package_name: ?[]const u8 = null,

    /// Current state of the package. Values are
    /// COPYING/COPY_FAILED/AVAILABLE/DELETING/DELETE_FAILED
    package_status: ?PackageStatus = null,

    /// Currently supports only TXT-DICTIONARY.
    package_type: ?PackageType = null,

    pub const json_field_names = .{
        .available_package_version = "AvailablePackageVersion",
        .created_at = "CreatedAt",
        .error_details = "ErrorDetails",
        .last_updated_at = "LastUpdatedAt",
        .package_description = "PackageDescription",
        .package_id = "PackageID",
        .package_name = "PackageName",
        .package_status = "PackageStatus",
        .package_type = "PackageType",
    };
};
