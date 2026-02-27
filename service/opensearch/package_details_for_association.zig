const PackageAssociationConfiguration = @import("package_association_configuration.zig").PackageAssociationConfiguration;

/// Details of a package that is associated with a domain.
pub const PackageDetailsForAssociation = struct {
    /// The configuration parameters for associating the package with a domain.
    association_configuration: ?PackageAssociationConfiguration,

    /// Internal ID of the package that you want to associate with a domain.
    package_id: []const u8,

    /// List of package IDs that must be linked to the domain before or
    /// simultaneously with
    /// the package association.
    prerequisite_package_id_list: ?[]const []const u8,

    pub const json_field_names = .{
        .association_configuration = "AssociationConfiguration",
        .package_id = "PackageID",
        .prerequisite_package_id_list = "PrerequisitePackageIDList",
    };
};
