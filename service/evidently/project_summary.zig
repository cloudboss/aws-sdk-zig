const aws = @import("aws");

const ProjectStatus = @import("project_status.zig").ProjectStatus;

/// A structure that contains configuration information about an Evidently
/// project.
pub const ProjectSummary = struct {
    /// The number of experiments currently in the project.
    active_experiment_count: ?i64,

    /// The number of ongoing launches currently in the project.
    active_launch_count: ?i64,

    /// The name or ARN of the project.
    arn: []const u8,

    /// The date and time that the project is created.
    created_time: i64,

    /// The description of the project.
    description: ?[]const u8,

    /// The number of experiments currently in the project.
    experiment_count: ?i64,

    /// The number of features currently in the project.
    feature_count: ?i64,

    /// The date and time that the project was most recently updated.
    last_updated_time: i64,

    /// The number of launches currently in the project, including launches that are
    /// ongoing, completed, and not started yet.
    launch_count: ?i64,

    /// The name of the project.
    name: []const u8,

    /// The current state of the project.
    status: ProjectStatus,

    /// The list of tag keys and values associated with this project.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .active_experiment_count = "activeExperimentCount",
        .active_launch_count = "activeLaunchCount",
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .experiment_count = "experimentCount",
        .feature_count = "featureCount",
        .last_updated_time = "lastUpdatedTime",
        .launch_count = "launchCount",
        .name = "name",
        .status = "status",
        .tags = "tags",
    };
};
