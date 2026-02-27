const ReplicationDestination = @import("replication_destination.zig").ReplicationDestination;
const RepositoryFilter = @import("repository_filter.zig").RepositoryFilter;

/// An array of objects representing the replication destinations and repository
/// filters
/// for a replication configuration.
pub const ReplicationRule = struct {
    /// An array of objects representing the destination for a replication rule.
    destinations: []const ReplicationDestination,

    /// An array of objects representing the filters for a replication rule.
    /// Specifying a
    /// repository filter for a replication rule provides a method for controlling
    /// which
    /// repositories in a private registry are replicated.
    repository_filters: ?[]const RepositoryFilter,

    pub const json_field_names = .{
        .destinations = "destinations",
        .repository_filters = "repositoryFilters",
    };
};
