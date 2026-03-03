/// Contains project summary information.
pub const ProjectSummary = struct {
    /// The date the project was created, in Unix epoch time.
    creation_date: ?i64 = null,

    /// The project's description.
    description: ?[]const u8 = null,

    /// The ID of the project.
    id: []const u8,

    /// The date the project was last updated, in Unix epoch time.
    last_update_date: ?i64 = null,

    /// The name of the project.
    name: []const u8,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .description = "description",
        .id = "id",
        .last_update_date = "lastUpdateDate",
        .name = "name",
    };
};
