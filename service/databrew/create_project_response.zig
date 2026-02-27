pub const CreateProjectResponse = struct {
    /// The name of the project that you created.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
