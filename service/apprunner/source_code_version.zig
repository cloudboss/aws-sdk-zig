const SourceCodeVersionType = @import("source_code_version_type.zig").SourceCodeVersionType;

/// Identifies a version of code that App Runner refers to within a source code
/// repository.
pub const SourceCodeVersion = struct {
    /// The type of version identifier.
    ///
    /// For a git-based repository, branches represent versions.
    @"type": SourceCodeVersionType,

    /// A source code version.
    ///
    /// For a git-based repository, a branch name maps to a specific version. App
    /// Runner uses the most recent commit to the branch.
    value: []const u8,

    pub const json_field_names = .{
        .@"type" = "Type",
        .value = "Value",
    };
};
