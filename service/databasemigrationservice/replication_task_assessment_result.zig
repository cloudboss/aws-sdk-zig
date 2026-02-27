/// The task assessment report in JSON format.
pub const ReplicationTaskAssessmentResult = struct {
    /// The task assessment results in JSON format.
    ///
    /// The response object only contains this field if you provide
    /// DescribeReplicationTaskAssessmentResultsMessage$ReplicationTaskArn in the
    /// request.
    assessment_results: ?[]const u8,

    /// The file containing the results of the task assessment.
    assessment_results_file: ?[]const u8,

    /// The status of the task assessment.
    assessment_status: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the replication task.
    replication_task_arn: ?[]const u8,

    /// The replication task identifier of the task on which the task assessment was
    /// run.
    replication_task_identifier: ?[]const u8,

    /// The date the task assessment was completed.
    replication_task_last_assessment_date: ?i64,

    /// The URL of the S3 object containing the task assessment results.
    ///
    /// The response object only contains this field if you provide
    /// DescribeReplicationTaskAssessmentResultsMessage$ReplicationTaskArn in the
    /// request.
    s3_object_url: ?[]const u8,

    pub const json_field_names = .{
        .assessment_results = "AssessmentResults",
        .assessment_results_file = "AssessmentResultsFile",
        .assessment_status = "AssessmentStatus",
        .replication_task_arn = "ReplicationTaskArn",
        .replication_task_identifier = "ReplicationTaskIdentifier",
        .replication_task_last_assessment_date = "ReplicationTaskLastAssessmentDate",
        .s3_object_url = "S3ObjectUrl",
    };
};
