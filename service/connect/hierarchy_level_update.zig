/// Contains information about the hierarchy level to update.
pub const HierarchyLevelUpdate = struct {
    /// The name of the user hierarchy level. Must not be more than 50 characters.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
