const DomainPackageStatus = @import("domain_package_status.zig").DomainPackageStatus;
const ErrorDetails = @import("error_details.zig").ErrorDetails;
const PackageType = @import("package_type.zig").PackageType;

/// Information on a package that is associated with a domain.
pub const DomainPackageDetails = struct {
    /// Name of the domain you've associated a package with.
    domain_name: ?[]const u8,

    /// State of the association. Values are
    /// ASSOCIATING/ASSOCIATION_FAILED/ACTIVE/DISSOCIATING/DISSOCIATION_FAILED.
    domain_package_status: ?DomainPackageStatus,

    /// Additional information if the package is in an error state. Null otherwise.
    error_details: ?ErrorDetails,

    /// Timestamp of the most-recent update to the association status.
    last_updated: ?i64,

    /// Internal ID of the package.
    package_id: ?[]const u8,

    /// User specified name of the package.
    package_name: ?[]const u8,

    /// Currently supports only TXT-DICTIONARY.
    package_type: ?PackageType,

    package_version: ?[]const u8,

    /// The relative path on Amazon ES nodes, which can be used as synonym_path when
    /// the package is synonym file.
    reference_path: ?[]const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .domain_package_status = "DomainPackageStatus",
        .error_details = "ErrorDetails",
        .last_updated = "LastUpdated",
        .package_id = "PackageID",
        .package_name = "PackageName",
        .package_type = "PackageType",
        .package_version = "PackageVersion",
        .reference_path = "ReferencePath",
    };
};
