const PackageGroupAssociationType = @import("package_group_association_type.zig").PackageGroupAssociationType;
const PackageFormat = @import("package_format.zig").PackageFormat;

/// A package associated with a package group.
pub const AssociatedPackage = struct {
    /// Describes the strength of the association between the package and package
    /// group. A strong match can be thought of as an
    /// exact match, and a weak match can be thought of as a variation match, for
    /// example, the package name matches a variation of the package group pattern.
    /// For more information about package group pattern matching, including strong
    /// and weak matches, see [Package group definition syntax and matching
    /// behavior](https://docs.aws.amazon.com/codeartifact/latest/ug/package-group-definition-syntax-matching-behavior.html)
    /// in the *CodeArtifact User Guide*.
    association_type: ?PackageGroupAssociationType,

    /// A format that specifies the type of the associated package.
    format: ?PackageFormat,

    /// The namespace of the associated package. The package component that
    /// specifies its
    /// namespace depends on its type. For example:
    ///
    /// * The namespace of a Maven package version is its `groupId`.
    ///
    /// * The namespace of an npm or Swift package version is its `scope`.
    ///
    /// * The namespace of a generic package is its `namespace`.
    ///
    /// * Python, NuGet, Ruby, and Cargo package versions do not contain a
    ///   corresponding component, package versions
    /// of those formats do not have a namespace.
    namespace: ?[]const u8,

    /// The name of the associated package.
    package: ?[]const u8,

    pub const json_field_names = .{
        .association_type = "associationType",
        .format = "format",
        .namespace = "namespace",
        .package = "package",
    };
};
