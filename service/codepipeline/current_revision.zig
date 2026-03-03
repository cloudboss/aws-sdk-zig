/// Represents information about a current revision.
pub const CurrentRevision = struct {
    /// The change identifier for the current revision.
    change_identifier: []const u8,

    /// The date and time when the most recent revision of the artifact was created,
    /// in
    /// timestamp format.
    created: ?i64 = null,

    /// The revision ID of the current version of an artifact.
    revision: []const u8,

    /// The summary of the most recent revision of the artifact.
    revision_summary: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_identifier = "changeIdentifier",
        .created = "created",
        .revision = "revision",
        .revision_summary = "revisionSummary",
    };
};
