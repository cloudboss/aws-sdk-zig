const ThesaurusStatus = @import("thesaurus_status.zig").ThesaurusStatus;

/// An array of summary information for a thesaurus or multiple thesauri.
pub const ThesaurusSummary = struct {
    /// The Unix timestamp when the thesaurus was created.
    created_at: ?i64 = null,

    /// The identifier of the thesaurus.
    id: ?[]const u8 = null,

    /// The name of the thesaurus.
    name: ?[]const u8 = null,

    /// The status of the thesaurus.
    status: ?ThesaurusStatus = null,

    /// The Unix timestamp when the thesaurus was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .id = "Id",
        .name = "Name",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
