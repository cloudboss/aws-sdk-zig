/// Information about an CloudFormation stack creation or update that occurred
/// around
/// the time of an incident and could be a potential cause of the incident.
pub const CloudFormationStackUpdate = struct {
    /// The timestamp for when the CloudFormation stack creation or update ended.
    /// Not reported
    /// for deployments that are still in progress.
    end_time: ?i64,

    /// The Amazon Resource Name (ARN) of the CloudFormation stack involved in the
    /// update.
    stack_arn: []const u8,

    /// The timestamp for when the CloudFormation stack creation or update began.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .stack_arn = "stackArn",
        .start_time = "startTime",
    };
};
