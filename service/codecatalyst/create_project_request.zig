pub const CreateProjectRequest = struct {
    /// The description of the project. This description will be displayed to all
    /// users of the project. We recommend providing a brief description of the
    /// project and its intended purpose.
    description: ?[]const u8,

    /// The friendly name of the project that will be displayed to users.
    display_name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .display_name = "displayName",
        .space_name = "spaceName",
    };
};
