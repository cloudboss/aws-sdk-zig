/// Information about the version (or revision) of a source artifact that
/// initiated a
/// pipeline execution.
pub const SourceRevision = struct {
    /// The name of the action that processed the revision to the source
    /// artifact.
    action_name: []const u8,

    /// The system-generated unique ID that identifies the revision number of the
    /// artifact.
    revision_id: ?[]const u8,

    /// Summary information about the most recent revision of the artifact. For
    /// GitHub and
    /// CodeCommit repositories, the commit message. For Amazon S3 buckets or
    /// actions,
    /// the user-provided content of a `codepipeline-artifact-revision-summary` key
    /// specified in the object metadata.
    revision_summary: ?[]const u8,

    /// The commit ID for the artifact revision. For artifacts stored in GitHub or
    /// CodeCommit repositories, the commit ID is linked to a commit details page.
    revision_url: ?[]const u8,

    pub const json_field_names = .{
        .action_name = "actionName",
        .revision_id = "revisionId",
        .revision_summary = "revisionSummary",
        .revision_url = "revisionUrl",
    };
};
