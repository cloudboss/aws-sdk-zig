pub const UpdateProjectResponse = struct {
    /// The date and time that the project was last modified.
    last_modified_date: ?i64 = null,

    /// The name of the project that you updated.
    name: []const u8,

    pub const json_field_names = .{
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
    };
};
