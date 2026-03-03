const AssessmentReportsDestination = @import("assessment_reports_destination.zig").AssessmentReportsDestination;
const DefaultExportDestination = @import("default_export_destination.zig").DefaultExportDestination;
const Role = @import("role.zig").Role;
const DeregistrationPolicy = @import("deregistration_policy.zig").DeregistrationPolicy;
const EvidenceFinderEnablement = @import("evidence_finder_enablement.zig").EvidenceFinderEnablement;

/// The settings object that holds all supported Audit Manager settings.
pub const Settings = struct {
    /// The default S3 destination bucket for storing assessment reports.
    default_assessment_reports_destination: ?AssessmentReportsDestination = null,

    /// The default S3 destination bucket for storing evidence finder exports.
    default_export_destination: ?DefaultExportDestination = null,

    /// The designated default audit owners.
    default_process_owners: ?[]const Role = null,

    /// The deregistration policy for your Audit Manager data. You can
    /// use this attribute to determine how your data is handled when you deregister
    /// Audit Manager.
    deregistration_policy: ?DeregistrationPolicy = null,

    /// The current evidence finder status and event data store details.
    evidence_finder_enablement: ?EvidenceFinderEnablement = null,

    /// Specifies whether Organizations is enabled.
    is_aws_org_enabled: ?bool = null,

    /// The KMS key details.
    kms_key: ?[]const u8 = null,

    /// The designated Amazon Simple Notification Service (Amazon SNS) topic.
    sns_topic: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_assessment_reports_destination = "defaultAssessmentReportsDestination",
        .default_export_destination = "defaultExportDestination",
        .default_process_owners = "defaultProcessOwners",
        .deregistration_policy = "deregistrationPolicy",
        .evidence_finder_enablement = "evidenceFinderEnablement",
        .is_aws_org_enabled = "isAwsOrgEnabled",
        .kms_key = "kmsKey",
        .sns_topic = "snsTopic",
    };
};
