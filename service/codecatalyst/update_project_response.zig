pub const UpdateProjectResponse = struct {
    /// The description of the project.
    description: ?[]const u8,

    /// The friendly name of the project displayed to users in Amazon CodeCatalyst.
    display_name: ?[]const u8,

    /// The name of the project.
    name: ?[]const u8,

    /// The name of the space.
    space_name: ?[]const u8,

    pub const json_field_names = .{
        .description = "description",
        .display_name = "displayName",
        .name = "name",
        .space_name = "spaceName",
    };
};
