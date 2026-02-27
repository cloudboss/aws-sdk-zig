/// An object, structure, or sub-structure of an analysis, template, or
/// dashboard.
pub const Entity = struct {
    /// The hierarchical path of the entity within the analysis, template, or
    /// dashboard definition tree.
    path: ?[]const u8,

    pub const json_field_names = .{
        .path = "Path",
    };
};
