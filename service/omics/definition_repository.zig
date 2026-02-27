const SourceReference = @import("source_reference.zig").SourceReference;

/// Contains information about a source code repository that hosts the workflow
/// definition files.
pub const DefinitionRepository = struct {
    /// The Amazon Resource Name (ARN) of the connection to the source code
    /// repository.
    connection_arn: []const u8,

    /// A list of file patterns to exclude when retrieving the workflow definition
    /// from the repository.
    exclude_file_patterns: ?[]const []const u8,

    /// The full repository identifier, including the repository owner and name. For
    /// example, 'repository-owner/repository-name'.
    full_repository_id: []const u8,

    /// The source reference for the repository, such as a branch name, tag, or
    /// commit ID.
    source_reference: ?SourceReference,

    pub const json_field_names = .{
        .connection_arn = "connectionArn",
        .exclude_file_patterns = "excludeFilePatterns",
        .full_repository_id = "fullRepositoryId",
        .source_reference = "sourceReference",
    };
};
