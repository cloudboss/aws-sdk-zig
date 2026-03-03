/// Filter settings that select for read set upload parts of interest.
pub const ReadSetUploadPartListFilter = struct {
    /// Filters for read set uploads after a specified time.
    created_after: ?i64 = null,

    /// Filters for read set part uploads before a specified time.
    created_before: ?i64 = null,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
    };
};
