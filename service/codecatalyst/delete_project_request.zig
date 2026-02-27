pub const DeleteProjectRequest = struct {
    /// The name of the project in the space. To retrieve a list of project names,
    /// use ListProjects.
    name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .space_name = "spaceName",
    };
};
