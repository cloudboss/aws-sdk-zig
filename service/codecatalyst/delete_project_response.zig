pub const DeleteProjectResponse = struct {
    /// The friendly name displayed to users of the project in Amazon CodeCatalyst.
    display_name: ?[]const u8,

    /// The name of the project in the space.
    name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .display_name = "displayName",
        .name = "name",
        .space_name = "spaceName",
    };
};
