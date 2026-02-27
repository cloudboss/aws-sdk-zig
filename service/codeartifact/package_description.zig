const PackageFormat = @import("package_format.zig").PackageFormat;
const PackageOriginConfiguration = @import("package_origin_configuration.zig").PackageOriginConfiguration;

/// Details about a package.
pub const PackageDescription = struct {
    /// A format that specifies the type of the package.
    format: ?PackageFormat,

    /// The name of the package.
    name: ?[]const u8,

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

    /// The package origin configuration for the package.
    origin_configuration: ?PackageOriginConfiguration,

    pub const json_field_names = .{
        .format = "format",
        .name = "name",
        .namespace = "namespace",
        .origin_configuration = "originConfiguration",
    };
};
