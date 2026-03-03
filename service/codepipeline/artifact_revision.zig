/// Represents revision details of an artifact.
pub const ArtifactRevision = struct {
    /// The date and time when the most recent revision of the artifact was created,
    /// in
    /// timestamp format.
    created: ?i64 = null,

    /// The name of an artifact. This name might be system-generated, such as
    /// "MyApp", or
    /// defined by the user when an action is created.
    name: ?[]const u8 = null,

    /// An additional identifier for a revision, such as a commit date or, for
    /// artifacts
    /// stored in Amazon S3 buckets, the ETag value.
    revision_change_identifier: ?[]const u8 = null,

    /// The revision ID of the artifact.
    revision_id: ?[]const u8 = null,

    /// Summary information about the most recent revision of the artifact. For
    /// GitHub and
    /// CodeCommit repositories, the commit message. For Amazon S3 buckets or
    /// actions, the
    /// user-provided content of a `codepipeline-artifact-revision-summary` key
    /// specified in the object metadata.
    revision_summary: ?[]const u8 = null,

    /// The commit ID for the artifact revision. For artifacts stored in GitHub or
    /// CodeCommit repositories, the commit ID is linked to a commit details page.
    revision_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .created = "created",
        .name = "name",
        .revision_change_identifier = "revisionChangeIdentifier",
        .revision_id = "revisionId",
        .revision_summary = "revisionSummary",
        .revision_url = "revisionUrl",
    };
};
