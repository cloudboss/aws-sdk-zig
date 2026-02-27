const RepositoryDescription = @import("repository_description.zig").RepositoryDescription;

pub const CreateRepositoryResult = struct {
    /// Information about the created repository after processing the request.
    repository: ?RepositoryDescription,

    pub const json_field_names = .{
        .repository = "repository",
    };
};
