/// Identifies a specific saved object by its type and unique identifier.
pub const SavedObjectIdentifier = struct {
    /// The unique identifier of the saved object.
    id: []const u8,

    /// The type of the saved object, such as `dashboard`, `visualization`,
    /// `index-pattern`, `search`, or `query`.
    type: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .type = "type",
    };
};
