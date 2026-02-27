const PackageAssociationConfiguration = @import("package_association_configuration.zig").PackageAssociationConfiguration;
const DomainPackageStatus = @import("domain_package_status.zig").DomainPackageStatus;
const ErrorDetails = @import("error_details.zig").ErrorDetails;
const PackageType = @import("package_type.zig").PackageType;

/// Information about a package that is associated with a domain. For more
/// information,
/// see [Custom packages
/// for Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/custom-packages.html).
pub const DomainPackageDetails = struct {
    /// The configuration for associating a package with an Amazon OpenSearch
    /// Service
    /// domain.
    association_configuration: ?PackageAssociationConfiguration,

    /// Name of the domain that the package is associated with.
    domain_name: ?[]const u8,

    /// State of the association.
    domain_package_status: ?DomainPackageStatus,

    /// Additional information if the package is in an error state. Null otherwise.
    error_details: ?ErrorDetails,

    /// Timestamp of the most recent update to the package association status.
    last_updated: ?i64,

    /// Internal ID of the package.
    package_id: ?[]const u8,

    /// User-specified name of the package.
    package_name: ?[]const u8,

    /// The type of package.
    package_type: ?PackageType,

    /// The current version of the package.
    package_version: ?[]const u8,

    /// A list of package IDs that must be associated with the domain before or with
    /// the
    /// package can be associated.
    prerequisite_package_id_list: ?[]const []const u8,

    /// The relative path of the package on the OpenSearch Service cluster nodes.
    /// This is
    /// `synonym_path` when the package is for synonym files.
    reference_path: ?[]const u8,

    pub const json_field_names = .{
        .association_configuration = "AssociationConfiguration",
        .domain_name = "DomainName",
        .domain_package_status = "DomainPackageStatus",
        .error_details = "ErrorDetails",
        .last_updated = "LastUpdated",
        .package_id = "PackageID",
        .package_name = "PackageName",
        .package_type = "PackageType",
        .package_version = "PackageVersion",
        .prerequisite_package_id_list = "PrerequisitePackageIDList",
        .reference_path = "ReferencePath",
    };
};
