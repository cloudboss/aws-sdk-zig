pub const UpdateProjectRequest = struct {
    /// The description of the project.
    description: ?[]const u8 = null,

    /// The name of the project.
    name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .space_name = "spaceName",
    };
};
