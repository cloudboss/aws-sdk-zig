const CreateSnapshotScheduleActionParameters = @import("create_snapshot_schedule_action_parameters.zig").CreateSnapshotScheduleActionParameters;

/// A JSON format string of the Amazon Redshift Serverless API operation with
/// input parameters. The following is an example of a target action.
///
/// `"{"CreateSnapshot": {"NamespaceName": "sampleNamespace","SnapshotName":
/// "sampleSnapshot", "retentionPeriod": "1"}}"`
pub const TargetAction = union(enum) {
    create_snapshot: ?CreateSnapshotScheduleActionParameters,

    pub const json_field_names = .{
        .create_snapshot = "createSnapshot",
    };
};
