const aws = @import("aws");

const Resource = @import("resource.zig").Resource;

/// A record that contains the information needed to demonstrate compliance with
/// the
/// requirements specified by a control. Examples of evidence include change
/// activity invoked
/// by a user, or a system configuration snapshot.
pub const Evidence = struct {
    /// Specifies whether the evidence is included in the assessment report.
    assessment_report_selection: ?[]const u8 = null,

    /// The names and values that are used by the evidence event. This includes an
    /// attribute
    /// name (such as `allowUsersToChangePassword`) and value (such as `true`
    /// or `false`).
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The identifier for the Amazon Web Services account.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services account that the evidence is collected from, and its
    /// organization path.
    aws_organization: ?[]const u8 = null,

    /// The evaluation status for automated evidence that falls under the compliance
    /// check
    /// category.
    ///
    /// * Audit Manager classes evidence as non-compliant if Security Hub reports a
    /// *Fail* result, or if Config reports a
    /// *Non-compliant* result.
    ///
    /// * Audit Manager classes evidence as compliant if Security Hub reports a
    /// *Pass* result, or if Config reports a
    /// *Compliant* result.
    ///
    /// * If a compliance check isn't available or applicable, then no compliance
    ///   evaluation can be made
    /// for that evidence. This is the case if the evidence uses Config or
    /// Security Hub as the underlying data source type, but those services aren't
    /// enabled. This is also the case if the evidence uses an underlying data
    /// source type
    /// that doesn't support compliance checks (such as manual evidence, Amazon Web
    /// Services
    /// API calls, or CloudTrail).
    compliance_check: ?[]const u8 = null,

    /// The data source where the evidence was collected from.
    data_source: ?[]const u8 = null,

    /// The name of the evidence event.
    event_name: ?[]const u8 = null,

    /// The Amazon Web Services service that the evidence is collected from.
    event_source: ?[]const u8 = null,

    /// The identifier for the Amazon Web Services account.
    evidence_aws_account_id: ?[]const u8 = null,

    /// The type of automated evidence.
    evidence_by_type: ?[]const u8 = null,

    /// The identifier for the folder that the evidence is stored in.
    evidence_folder_id: ?[]const u8 = null,

    /// The unique identifier for the user or role that's associated with
    /// the evidence.
    iam_id: ?[]const u8 = null,

    /// The identifier for the evidence.
    id: ?[]const u8 = null,

    /// The list of resources that are assessed to generate the evidence.
    resources_included: ?[]const Resource = null,

    /// The timestamp that represents when the evidence was collected.
    time: ?i64 = null,

    pub const json_field_names = .{
        .assessment_report_selection = "assessmentReportSelection",
        .attributes = "attributes",
        .aws_account_id = "awsAccountId",
        .aws_organization = "awsOrganization",
        .compliance_check = "complianceCheck",
        .data_source = "dataSource",
        .event_name = "eventName",
        .event_source = "eventSource",
        .evidence_aws_account_id = "evidenceAwsAccountId",
        .evidence_by_type = "evidenceByType",
        .evidence_folder_id = "evidenceFolderId",
        .iam_id = "iamId",
        .id = "id",
        .resources_included = "resourcesIncluded",
        .time = "time",
    };
};
