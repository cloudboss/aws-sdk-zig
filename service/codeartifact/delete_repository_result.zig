const RepositoryDescription = @import("repository_description.zig").RepositoryDescription;

pub const DeleteRepositoryResult = struct {
    /// Information about the deleted repository after processing the request.
    repository: ?RepositoryDescription = null,

    pub const json_field_names = .{
        .repository = "repository",
    };
};
