const ProjectStatus = @import("project_status.zig").ProjectStatus;

/// Information about a project.
pub const ProjectSummary = struct {
    /// The time that the project was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the project.
    project_arn: []const u8,

    /// The description of the project.
    project_description: ?[]const u8 = null,

    /// The ID of the project.
    project_id: []const u8,

    /// The name of the project.
    project_name: []const u8,

    /// The status of the project.
    project_status: ProjectStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .project_arn = "ProjectArn",
        .project_description = "ProjectDescription",
        .project_id = "ProjectId",
        .project_name = "ProjectName",
        .project_status = "ProjectStatus",
    };
};
