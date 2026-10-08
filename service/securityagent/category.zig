/// Represents a category assigned to a security testing task.
pub const Category = struct {
    /// Indicates whether this is the primary category for the task.
    is_primary: ?bool = null,

    /// The name of the category.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_primary = "isPrimary",
        .name = "name",
    };
};
