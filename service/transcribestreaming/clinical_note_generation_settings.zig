const MedicalScribeNoteTemplate = @import("medical_scribe_note_template.zig").MedicalScribeNoteTemplate;

/// The output configuration for aggregated transcript and clinical note
/// generation.
pub const ClinicalNoteGenerationSettings = struct {
    /// Specify one of the following templates to use for the clinical note summary.
    /// The default is `HISTORY_AND_PHYSICAL`.
    ///
    /// * HISTORY_AND_PHYSICAL: Provides summaries for key sections of the clinical
    ///   documentation. Examples of sections include Chief Complaint, History of
    ///   Present Illness, Review of Systems, Past Medical History, Assessment, and
    ///   Plan.
    ///
    /// * GIRPP: Provides summaries based on the patients progress toward goals.
    ///   Examples of sections include Goal, Intervention,
    /// Response, Progress, and Plan.
    ///
    /// * BIRP: Focuses on the patient's behavioral patterns and responses. Examples
    ///   of sections include Behavior, Intervention, Response, and Plan.
    ///
    /// * SIRP: Emphasizes the situational context of therapy. Examples of sections
    ///   include Situation, Intervention, Response, and Plan.
    ///
    /// * DAP: Provides a simplified format for clinical documentation. Examples of
    ///   sections include Data, Assessment, and Plan.
    ///
    /// * BEHAVIORAL_SOAP: Behavioral health focused documentation format. Examples
    ///   of sections include Subjective, Objective, Assessment, and Plan.
    ///
    /// * PHYSICAL_SOAP: Physical health focused documentation format. Examples of
    ///   sections include Subjective, Objective, Assessment, and Plan.
    note_template: ?MedicalScribeNoteTemplate,

    /// The name of the Amazon S3 bucket where you want the output of Amazon Web
    /// Services HealthScribe post-stream analytics stored. Don't include the
    /// `S3://` prefix of the specified bucket.
    ///
    /// HealthScribe outputs transcript and clinical note files under the prefix:
    /// `S3://$output-bucket-name/healthscribe-streaming/session-id/post-stream-analytics/clinical-notes`
    ///
    /// The role `ResourceAccessRoleArn` specified in the
    /// `MedicalScribeConfigurationEvent` must have
    /// permission to use the specified location. You can change Amazon S3
    /// permissions using the [
    /// Amazon Web Services Management Console
    /// ](https://console.aws.amazon.com/s3). See also [Permissions Required for IAM
    /// User Roles
    /// ](https://docs.aws.amazon.com/transcribe/latest/dg/security_iam_id-based-policy-examples.html#auth-role-iam-user) .
    output_bucket_name: []const u8,

    pub const json_field_names = .{
        .note_template = "NoteTemplate",
        .output_bucket_name = "OutputBucketName",
    };
};
