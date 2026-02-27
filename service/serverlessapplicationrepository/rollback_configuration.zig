const RollbackTrigger = @import("rollback_trigger.zig").RollbackTrigger;

/// This property corresponds to the *AWS CloudFormation
/// [RollbackConfiguration](https://docs.aws.amazon.com/goto/WebAPI/cloudformation-2010-05-15/RollbackConfiguration)
/// * Data Type.
pub const RollbackConfiguration = struct {
    /// This property corresponds to the content of the same name for the *AWS
    /// CloudFormation
    /// [RollbackConfiguration](https://docs.aws.amazon.com/goto/WebAPI/cloudformation-2010-05-15/RollbackConfiguration)
    /// * Data Type.
    monitoring_time_in_minutes: ?i32,

    /// This property corresponds to the content of the same name for the *AWS
    /// CloudFormation
    /// [RollbackConfiguration](https://docs.aws.amazon.com/goto/WebAPI/cloudformation-2010-05-15/RollbackConfiguration)
    /// * Data Type.
    rollback_triggers: ?[]const RollbackTrigger,

    pub const json_field_names = .{
        .monitoring_time_in_minutes = "MonitoringTimeInMinutes",
        .rollback_triggers = "RollbackTriggers",
    };
};
