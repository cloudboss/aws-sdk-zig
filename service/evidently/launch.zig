const aws = @import("aws");

const LaunchExecution = @import("launch_execution.zig").LaunchExecution;
const LaunchGroup = @import("launch_group.zig").LaunchGroup;
const MetricMonitor = @import("metric_monitor.zig").MetricMonitor;
const ScheduledSplitsLaunchDefinition = @import("scheduled_splits_launch_definition.zig").ScheduledSplitsLaunchDefinition;
const LaunchStatus = @import("launch_status.zig").LaunchStatus;
const LaunchType = @import("launch_type.zig").LaunchType;

/// This structure contains the configuration details of one Evidently launch.
pub const Launch = struct {
    /// The ARN of the launch.
    arn: []const u8,

    /// The date and time that the launch is created.
    created_time: i64,

    /// The description of the launch.
    description: ?[]const u8,

    /// A structure that contains information about the start and end times of the
    /// launch.
    execution: ?LaunchExecution,

    /// An array of structures that define the feature variations that are being
    /// used in the launch.
    groups: ?[]const LaunchGroup,

    /// The date and time that the launch was most recently updated.
    last_updated_time: i64,

    /// An array of structures that define the metrics that are being used to
    /// monitor the launch performance.
    metric_monitors: ?[]const MetricMonitor,

    /// The name of the launch.
    name: []const u8,

    /// The name or ARN of the project that contains the launch.
    project: ?[]const u8,

    /// This value is used when Evidently assigns a particular user session to the
    /// launch, to help create a randomization ID to determine which variation the
    /// user session is served. This randomization ID is a combination of the entity
    /// ID and `randomizationSalt`.
    randomization_salt: ?[]const u8,

    /// An array of structures that define the traffic allocation percentages among
    /// the feature variations during each step of the launch.
    scheduled_splits_definition: ?ScheduledSplitsLaunchDefinition,

    /// The current state of the launch.
    status: LaunchStatus,

    /// If the launch was stopped, this is the string that was entered by the person
    /// who stopped the launch, to explain why it was stopped.
    status_reason: ?[]const u8,

    /// The list of tag keys and values associated with this launch.
    tags: ?[]const aws.map.StringMapEntry,

    /// The type of launch.
    @"type": LaunchType,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .execution = "execution",
        .groups = "groups",
        .last_updated_time = "lastUpdatedTime",
        .metric_monitors = "metricMonitors",
        .name = "name",
        .project = "project",
        .randomization_salt = "randomizationSalt",
        .scheduled_splits_definition = "scheduledSplitsDefinition",
        .status = "status",
        .status_reason = "statusReason",
        .tags = "tags",
        .@"type" = "type",
    };
};
