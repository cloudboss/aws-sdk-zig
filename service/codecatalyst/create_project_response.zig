pub const CreateProjectResponse = struct {
    /// The description of the project.
    description: ?[]const u8 = null,

    /// The friendly name of the project.
    display_name: ?[]const u8 = null,

    /// The name of the project in the space.
    name: []const u8,

    /// The name of the space.
    space_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .display_name = "displayName",
        .name = "name",
        .space_name = "spaceName",
    };
};
