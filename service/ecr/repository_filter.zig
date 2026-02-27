const RepositoryFilterType = @import("repository_filter_type.zig").RepositoryFilterType;

/// The filter settings used with image replication. Specifying a repository
/// filter to a
/// replication rule provides a method for controlling which repositories in a
/// private
/// registry are replicated. If no filters are added, the contents of all
/// repositories are
/// replicated.
pub const RepositoryFilter = struct {
    /// The repository filter details. When the `PREFIX_MATCH` filter type is
    /// specified, this value is required and should be the repository name prefix
    /// to configure
    /// replication for.
    filter: []const u8,

    /// The repository filter type. The only supported value is `PREFIX_MATCH`,
    /// which is a repository name prefix specified with the `filter`
    /// parameter.
    filter_type: RepositoryFilterType,

    pub const json_field_names = .{
        .filter = "filter",
        .filter_type = "filterType",
    };
};
