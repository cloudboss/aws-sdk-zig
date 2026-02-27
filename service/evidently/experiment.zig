const aws = @import("aws");

const ExperimentExecution = @import("experiment_execution.zig").ExperimentExecution;
const MetricGoal = @import("metric_goal.zig").MetricGoal;
const OnlineAbDefinition = @import("online_ab_definition.zig").OnlineAbDefinition;
const ExperimentSchedule = @import("experiment_schedule.zig").ExperimentSchedule;
const ExperimentStatus = @import("experiment_status.zig").ExperimentStatus;
const Treatment = @import("treatment.zig").Treatment;
const ExperimentType = @import("experiment_type.zig").ExperimentType;

/// A structure containing the configuration details of an experiment.
pub const Experiment = struct {
    /// The ARN of the experiment.
    arn: []const u8,

    /// The date and time that the experiment is first created.
    created_time: i64,

    /// A description of the experiment.
    description: ?[]const u8,

    /// A structure that contains the date and time that the experiment started and
    /// ended.
    execution: ?ExperimentExecution,

    /// The date and time that the experiment was most recently updated.
    last_updated_time: i64,

    /// An array of structures that defines the metrics used for the experiment, and
    /// whether a higher or lower value for each metric is the goal.
    metric_goals: ?[]const MetricGoal,

    /// The name of the experiment.
    name: []const u8,

    /// A structure that contains the configuration of which variation to use as the
    /// "control" version. The "control" version is used for comparison with other
    /// variations. This structure also specifies how much experiment traffic is
    /// allocated to each variation.
    online_ab_definition: ?OnlineAbDefinition,

    /// The name or ARN of the project that contains this experiment.
    project: ?[]const u8,

    /// This value is used when Evidently assigns a particular user session to the
    /// experiment. It helps create a randomization ID to determine which variation
    /// the user session is served. This randomization ID is a combination of the
    /// entity ID and `randomizationSalt`.
    randomization_salt: ?[]const u8,

    /// In thousandths of a percent, the amount of the available audience that is
    /// allocated to this experiment. The available audience is the total audience
    /// minus the audience that you have allocated to overrides or current launches
    /// of this feature.
    ///
    /// This is represented in thousandths of a percent, so a value of 10,000 is 10%
    /// of the available audience.
    sampling_rate: i64 = 0,

    /// A structure that contains the time and date that Evidently completed the
    /// analysis of the experiment.
    schedule: ?ExperimentSchedule,

    /// The audience segment being used for the experiment, if a segment is being
    /// used.
    segment: ?[]const u8,

    /// The current state of the experiment.
    status: ExperimentStatus,

    /// If the experiment was stopped, this is the string that was entered by the
    /// person who stopped the experiment, to explain why it was stopped.
    status_reason: ?[]const u8,

    /// The list of tag keys and values associated with this experiment.
    tags: ?[]const aws.map.StringMapEntry,

    /// An array of structures that describe the configuration of each feature
    /// variation used in the experiment.
    treatments: ?[]const Treatment,

    /// The type of this experiment. Currently, this value must be
    /// `aws.experiment.onlineab`.
    type: ExperimentType,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .execution = "execution",
        .last_updated_time = "lastUpdatedTime",
        .metric_goals = "metricGoals",
        .name = "name",
        .online_ab_definition = "onlineAbDefinition",
        .project = "project",
        .randomization_salt = "randomizationSalt",
        .sampling_rate = "samplingRate",
        .schedule = "schedule",
        .segment = "segment",
        .status = "status",
        .status_reason = "statusReason",
        .tags = "tags",
        .treatments = "treatments",
        .type = "type",
    };
};
