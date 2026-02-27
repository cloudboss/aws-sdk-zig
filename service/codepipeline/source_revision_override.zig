const SourceRevisionType = @import("source_revision_type.zig").SourceRevisionType;

/// A list that allows you to specify, or override, the source revision for a
/// pipeline
/// execution that's being started. A source revision is the version with all
/// the changes to
/// your application code, or source artifact, for the pipeline execution.
///
/// For the `S3_OBJECT_VERSION_ID` and `S3_OBJECT_KEY` types of
/// source revisions, either of the types can be used independently, or they can
/// be used
/// together to override the source with a specific ObjectKey and VersionID.
pub const SourceRevisionOverride = struct {
    /// The name of the action where the override will be applied.
    action_name: []const u8,

    /// The type of source revision, based on the source provider. For example, the
    /// revision
    /// type for the CodeCommit action provider is the commit ID.
    revision_type: SourceRevisionType,

    /// The source revision, or version of your source artifact, with the changes
    /// that you
    /// want to run in the pipeline execution.
    revision_value: []const u8,

    pub const json_field_names = .{
        .action_name = "actionName",
        .revision_type = "revisionType",
        .revision_value = "revisionValue",
    };
};
