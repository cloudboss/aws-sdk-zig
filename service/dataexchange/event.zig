const RevisionPublished = @import("revision_published.zig").RevisionPublished;

/// What occurs to start an action.
pub const Event = struct {
    /// What occurs to start the revision publish action.
    revision_published: ?RevisionPublished,

    pub const json_field_names = .{
        .revision_published = "RevisionPublished",
    };
};
