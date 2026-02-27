pub const DeleteProjectResponse = struct {
    /// The name of the project that you deleted.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
