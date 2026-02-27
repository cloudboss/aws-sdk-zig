/// Information about a project.
pub const ProjectSummary = struct {
    /// The description of the project.
    description: ?[]const u8,

    /// The friendly name displayed to users of the project in Amazon CodeCatalyst.
    display_name: ?[]const u8,

    /// The name of the project in the space.
    name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .display_name = "displayName",
        .name = "name",
    };
};
