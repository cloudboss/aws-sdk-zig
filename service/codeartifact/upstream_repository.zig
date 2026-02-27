/// Information about an upstream repository. A list of `UpstreamRepository`
/// objects is an input parameter to
/// [CreateRepository](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_CreateRepository.html)
/// and
/// [UpdateRepository](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_UpdateRepository.html).
pub const UpstreamRepository = struct {
    /// The name of an upstream repository.
    repository_name: []const u8,

    pub const json_field_names = .{
        .repository_name = "repositoryName",
    };
};
