const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const AlarmStateInformation = @import("alarm_state_information.zig").AlarmStateInformation;

/// Includes information about the specified association.
pub const AssociationExecution = struct {
    alarm_configuration: ?AlarmConfiguration,

    /// The association ID.
    association_id: ?[]const u8,

    /// The association version.
    association_version: ?[]const u8,

    /// The time the execution started.
    created_time: ?i64,

    /// Detailed status information about the execution.
    detailed_status: ?[]const u8,

    /// The execution ID for the association.
    execution_id: ?[]const u8,

    /// The date of the last execution.
    last_execution_date: ?i64,

    /// An aggregate status of the resources in the execution based on the status
    /// type.
    resource_count_by_status: ?[]const u8,

    /// The status of the association execution.
    status: ?[]const u8,

    /// The CloudWatch alarms that were invoked by the association.
    triggered_alarms: ?[]const AlarmStateInformation,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .association_id = "AssociationId",
        .association_version = "AssociationVersion",
        .created_time = "CreatedTime",
        .detailed_status = "DetailedStatus",
        .execution_id = "ExecutionId",
        .last_execution_date = "LastExecutionDate",
        .resource_count_by_status = "ResourceCountByStatus",
        .status = "Status",
        .triggered_alarms = "TriggeredAlarms",
    };
};
