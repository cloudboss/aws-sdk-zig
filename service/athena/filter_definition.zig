/// A string for searching notebook names.
pub const FilterDefinition = struct {
    /// The name of the notebook to search for.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
