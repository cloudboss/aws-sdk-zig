pub const DeleteProjectRequest = struct {
    /// The name of the project to be deleted.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
