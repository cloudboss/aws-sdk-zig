/// Returns information about a target for a pull request.
pub const Target = struct {
    /// The branch of the repository where the pull request changes are merged. Also
    /// known as
    /// the destination branch.
    destination_reference: ?[]const u8 = null,

    /// The name of the repository that contains the pull request.
    repository_name: []const u8,

    /// The branch of the repository that contains the changes for the pull request.
    /// Also known as the source branch.
    source_reference: []const u8,

    pub const json_field_names = .{
        .destination_reference = "destinationReference",
        .repository_name = "repositoryName",
        .source_reference = "sourceReference",
    };
};
