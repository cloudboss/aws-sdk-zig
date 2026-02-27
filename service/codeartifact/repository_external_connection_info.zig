const PackageFormat = @import("package_format.zig").PackageFormat;
const ExternalConnectionStatus = @import("external_connection_status.zig").ExternalConnectionStatus;

/// Contains information about the external connection of a repository.
pub const RepositoryExternalConnectionInfo = struct {
    /// The name of the external connection associated with a repository.
    external_connection_name: ?[]const u8,

    /// The package format associated with a repository's external connection. The
    /// valid package formats are:
    ///
    /// * `npm`: A Node Package Manager (npm) package.
    ///
    /// * `pypi`: A Python Package Index (PyPI) package.
    ///
    /// * `maven`: A Maven package that contains compiled code in a distributable
    ///   format, such as a JAR file.
    ///
    /// * `nuget`: A NuGet package.
    ///
    /// * `generic`: A generic package.
    ///
    /// * `ruby`: A Ruby package.
    ///
    /// * `swift`: A Swift package.
    ///
    /// * `cargo`: A Cargo package.
    package_format: ?PackageFormat,

    /// The status of the external connection of a repository. There is one valid
    /// value, `Available`.
    status: ?ExternalConnectionStatus,

    pub const json_field_names = .{
        .external_connection_name = "externalConnectionName",
        .package_format = "packageFormat",
        .status = "status",
    };
};
