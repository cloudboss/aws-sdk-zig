pub const Application = struct {
    /// The description of the application.
    description: ?[]const u8 = null,

    /// The application ID.
    id: ?[]const u8 = null,

    /// The application name.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
        .name = "Name",
    };
};
