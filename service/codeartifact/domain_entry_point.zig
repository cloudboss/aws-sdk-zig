/// Information about how a package originally entered the CodeArtifact domain.
/// For packages published directly to CodeArtifact, the entry point is the
/// repository it was published to.
/// For packages ingested from an external repository, the entry point is the
/// external connection that it was ingested from. An external
/// connection is a CodeArtifact repository that is connected to an external
/// repository such as the npm registry or NuGet gallery.
///
/// If a package version exists in a repository and is updated, for example if a
/// package of the same version is added
/// with additional assets, the package version's `DomainEntryPoint` will not
/// change from the original package version's value.
pub const DomainEntryPoint = struct {
    /// The name of the external connection that a package was ingested from.
    external_connection_name: ?[]const u8,

    /// The name of the repository that a package was originally published to.
    repository_name: ?[]const u8,

    pub const json_field_names = .{
        .external_connection_name = "externalConnectionName",
        .repository_name = "repositoryName",
    };
};
