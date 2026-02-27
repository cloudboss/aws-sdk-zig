/// Identifies a specific IoT SiteWise Monitor project.
pub const ProjectResource = struct {
    /// The ID of the project.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
