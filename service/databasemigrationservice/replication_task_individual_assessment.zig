/// Provides information that describes an individual assessment from a
/// premigration
/// assessment run.
pub const ReplicationTaskIndividualAssessment = struct {
    /// Name of this individual assessment.
    individual_assessment_name: ?[]const u8,

    /// ARN of the premigration assessment run that is created to run this
    /// individual
    /// assessment.
    replication_task_assessment_run_arn: ?[]const u8,

    /// Amazon Resource Name (ARN) of this individual assessment.
    replication_task_individual_assessment_arn: ?[]const u8,

    /// Date when this individual assessment was started as part of running the
    /// `StartReplicationTaskAssessmentRun` operation.
    replication_task_individual_assessment_start_date: ?i64,

    /// Individual assessment status.
    ///
    /// This status can have one of the following values:
    ///
    /// * `"cancelled"`
    ///
    /// * `"error"`
    ///
    /// * `"failed"`
    ///
    /// * `"passed"`
    ///
    /// * `"pending"`
    ///
    /// * `"skipped"`
    ///
    /// * `"running"`
    status: ?[]const u8,

    pub const json_field_names = .{
        .individual_assessment_name = "IndividualAssessmentName",
        .replication_task_assessment_run_arn = "ReplicationTaskAssessmentRunArn",
        .replication_task_individual_assessment_arn = "ReplicationTaskIndividualAssessmentArn",
        .replication_task_individual_assessment_start_date = "ReplicationTaskIndividualAssessmentStartDate",
        .status = "Status",
    };
};
