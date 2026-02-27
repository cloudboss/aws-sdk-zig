pub const DeleteProjectRequest = struct {
    /// The Amazon Resource Name (ARN) of the project that you want to delete.
    project_arn: []const u8,

    pub const json_field_names = .{
        .project_arn = "ProjectArn",
    };
};
