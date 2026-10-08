/// Contains summary information about a security requirement.
pub const SecurityRequirementSummary = struct {
    /// The date and time the security requirement was created, in UTC format.
    created_at: i64,

    /// A description of the security requirement.
    description: []const u8,

    /// The name of the security requirement.
    name: []const u8,

    /// The unique identifier of the pack containing the security requirement.
    pack_id: []const u8,

    /// The date and time the security requirement was last updated, in UTC format.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .pack_id = "packId",
        .updated_at = "updatedAt",
    };
};
