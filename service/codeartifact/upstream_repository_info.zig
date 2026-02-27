/// Information about an upstream repository.
pub const UpstreamRepositoryInfo = struct {
    /// The name of an upstream repository.
    repository_name: ?[]const u8,

    pub const json_field_names = .{
        .repository_name = "repositoryName",
    };
};
