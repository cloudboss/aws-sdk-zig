const RepositoryExternalConnectionInfo = @import("repository_external_connection_info.zig").RepositoryExternalConnectionInfo;
const UpstreamRepositoryInfo = @import("upstream_repository_info.zig").UpstreamRepositoryInfo;

/// The details of a repository stored in CodeArtifact. A CodeArtifact
/// repository contains a set of
/// package versions, each of which maps to a set of assets. Repositories are
/// polyglot—a single
/// repository can contain packages of any supported type. Each repository
/// exposes endpoints for
/// fetching and publishing packages using tools like the `npm` CLI, the Maven
/// CLI
/// (`mvn`), and `pip`. You can create up to 100 repositories per Amazon Web
/// Services
/// account.
pub const RepositoryDescription = struct {
    /// The 12-digit account number of the Amazon Web Services account that manages
    /// the repository.
    administrator_account: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the repository.
    arn: ?[]const u8 = null,

    /// A timestamp that represents the date and time the repository was created.
    created_time: ?i64 = null,

    /// A text description of the repository.
    description: ?[]const u8 = null,

    /// The name of the domain that contains the repository.
    domain_name: ?[]const u8 = null,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain that contains the repository. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// An array of external connections associated with the repository.
    external_connections: ?[]const RepositoryExternalConnectionInfo = null,

    /// The name of the repository.
    name: ?[]const u8 = null,

    /// A list of upstream repositories to associate with the repository. The order
    /// of the upstream repositories
    /// in the list determines their priority order when CodeArtifact looks for a
    /// requested package version. For more
    /// information, see [Working with upstream
    /// repositories](https://docs.aws.amazon.com/codeartifact/latest/ug/repos-upstream.html).
    upstreams: ?[]const UpstreamRepositoryInfo = null,

    pub const json_field_names = .{
        .administrator_account = "administratorAccount",
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .domain_name = "domainName",
        .domain_owner = "domainOwner",
        .external_connections = "externalConnections",
        .name = "name",
        .upstreams = "upstreams",
    };
};
