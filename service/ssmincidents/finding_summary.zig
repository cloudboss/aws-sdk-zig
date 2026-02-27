/// Identifying information about the finding.
pub const FindingSummary = struct {
    /// The ID of the finding.
    id: []const u8,

    /// The timestamp for when the finding was last updated.
    last_modified_time: i64,

    pub const json_field_names = .{
        .id = "id",
        .last_modified_time = "lastModifiedTime",
    };
};
