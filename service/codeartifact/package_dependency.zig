/// Details about a package dependency.
pub const PackageDependency = struct {
    /// The type of a package dependency. The possible values depend on the package
    /// type.
    ///
    /// * npm: `regular`, `dev`, `peer`, `optional`
    ///
    /// * maven: `optional`, `parent`, `compile`, `runtime`, `test`, `system`,
    ///   `provided`.
    ///
    /// Note that `parent` is not a regular Maven dependency type; instead this is
    /// extracted from the `` element if one is defined in the package version's POM
    /// file.
    ///
    /// * nuget: The `dependencyType` field is never set for NuGet packages.
    ///
    /// * pypi: `Requires-Dist`
    dependency_type: ?[]const u8 = null,

    /// The namespace of the package that this package depends on. The package
    /// component that specifies its
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
    namespace: ?[]const u8 = null,

    /// The name of the package that this package depends on.
    package: ?[]const u8 = null,

    /// The required version, or version range, of the package that this package
    /// depends on. The version format
    /// is specific to the package type. For example, the following are possible
    /// valid required versions: `1.2.3`,
    /// `^2.3.4`, or `4.x`.
    version_requirement: ?[]const u8 = null,

    pub const json_field_names = .{
        .dependency_type = "dependencyType",
        .namespace = "namespace",
        .package = "package",
        .version_requirement = "versionRequirement",
    };
};
