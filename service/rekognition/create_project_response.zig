pub const CreateProjectResponse = struct {
    /// The Amazon Resource Name (ARN) of the new project. You can use the ARN to
    /// configure IAM access to the project.
    project_arn: ?[]const u8,

    pub const json_field_names = .{
        .project_arn = "ProjectArn",
    };
};
