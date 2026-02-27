const Tag = @import("tag.zig").Tag;
const UpstreamRepository = @import("upstream_repository.zig").UpstreamRepository;

pub const CreateRepositoryRequest = struct {
    /// A description of the created repository.
    description: ?[]const u8,

    /// The name of the domain that contains the created repository.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8,

    /// The name of the repository to create.
    repository: []const u8,

    /// One or more tag key-value pairs for the repository.
    tags: ?[]const Tag,

    /// A list of upstream repositories to associate with the repository. The order
    /// of the upstream repositories
    /// in the list determines their priority order when CodeArtifact looks for a
    /// requested package version. For more
    /// information, see [Working with upstream
    /// repositories](https://docs.aws.amazon.com/codeartifact/latest/ug/repos-upstream.html).
    upstreams: ?[]const UpstreamRepository,

    pub const json_field_names = .{
        .description = "description",
        .domain = "domain",
        .domain_owner = "domainOwner",
        .repository = "repository",
        .tags = "tags",
        .upstreams = "upstreams",
    };
};
