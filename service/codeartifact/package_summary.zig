const PackageFormat = @import("package_format.zig").PackageFormat;
const PackageOriginConfiguration = @import("package_origin_configuration.zig").PackageOriginConfiguration;

/// Details about a package, including its format, namespace, and name.
pub const PackageSummary = struct {
    /// The format of the package.
    format: ?PackageFormat,

    /// The namespace of the package. The package component that specifies its
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

    /// A
    /// [PackageOriginConfiguration](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageOriginConfiguration.html)
    /// object that contains a
    /// [PackageOriginRestrictions](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageOriginRestrictions.html) object
    /// that contains information about the upstream and publish package origin
    /// restrictions.
    origin_configuration: ?PackageOriginConfiguration,

    /// The name of the package.
    package: ?[]const u8,

    pub const json_field_names = .{
        .format = "format",
        .namespace = "namespace",
        .origin_configuration = "originConfiguration",
        .package = "package",
    };
};
