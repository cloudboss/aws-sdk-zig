const aws = @import("aws");

const ProjectAppConfigResource = @import("project_app_config_resource.zig").ProjectAppConfigResource;
const ProjectDataDelivery = @import("project_data_delivery.zig").ProjectDataDelivery;
const ProjectStatus = @import("project_status.zig").ProjectStatus;

/// This structure defines a project, which is the logical object in Evidently
/// that can contain features, launches, and experiments. Use projects to group
/// similar features together.
pub const Project = struct {
    /// The number of ongoing experiments currently in the project.
    active_experiment_count: ?i64 = null,

    /// The number of ongoing launches currently in the project.
    active_launch_count: ?i64 = null,

    /// This structure defines the configuration of how your application integrates
    /// with AppConfig to run client-side evaluation.
    app_config_resource: ?ProjectAppConfigResource = null,

    /// The name or ARN of the project.
    arn: []const u8,

    /// The date and time that the project is created.
    created_time: i64,

    /// A structure that contains information about where Evidently is to store
    /// evaluation events for longer term storage.
    data_delivery: ?ProjectDataDelivery = null,

    /// The user-entered description of the project.
    description: ?[]const u8 = null,

    /// The number of experiments currently in the project. This includes all
    /// experiments that have been created and not deleted, whether they are ongoing
    /// or not.
    experiment_count: ?i64 = null,

    /// The number of features currently in the project.
    feature_count: ?i64 = null,

    /// The date and time that the project was most recently updated.
    last_updated_time: i64,

    /// The number of launches currently in the project. This includes all launches
    /// that have been created and not deleted, whether they are ongoing or not.
    launch_count: ?i64 = null,

    /// The name of the project.
    name: []const u8,

    /// The current state of the project.
    status: ProjectStatus,

    /// The list of tag keys and values associated with this project.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .active_experiment_count = "activeExperimentCount",
        .active_launch_count = "activeLaunchCount",
        .app_config_resource = "appConfigResource",
        .arn = "arn",
        .created_time = "createdTime",
        .data_delivery = "dataDelivery",
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
