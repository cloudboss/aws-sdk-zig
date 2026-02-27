const aws = @import("aws");

const Action = @import("action.zig").Action;
const Compliance = @import("compliance.zig").Compliance;
const Detection = @import("detection.zig").Detection;
const FindingProviderFields = @import("finding_provider_fields.zig").FindingProviderFields;
const GeneratorDetails = @import("generator_details.zig").GeneratorDetails;
const Malware = @import("malware.zig").Malware;
const Network = @import("network.zig").Network;
const NetworkPathComponent = @import("network_path_component.zig").NetworkPathComponent;
const Note = @import("note.zig").Note;
const PatchSummary = @import("patch_summary.zig").PatchSummary;
const ProcessDetails = @import("process_details.zig").ProcessDetails;
const RecordState = @import("record_state.zig").RecordState;
const RelatedFinding = @import("related_finding.zig").RelatedFinding;
const Remediation = @import("remediation.zig").Remediation;
const Resource = @import("resource.zig").Resource;
const Severity = @import("severity.zig").Severity;
const ThreatIntelIndicator = @import("threat_intel_indicator.zig").ThreatIntelIndicator;
const Threat = @import("threat.zig").Threat;
const VerificationState = @import("verification_state.zig").VerificationState;
const Vulnerability = @import("vulnerability.zig").Vulnerability;
const Workflow = @import("workflow.zig").Workflow;
const WorkflowState = @import("workflow_state.zig").WorkflowState;

/// Provides a consistent format for Security Hub findings.
/// `AwsSecurityFinding` format allows you to share findings between Amazon Web
/// Services
/// security services and third-party solutions.
///
/// A finding is a potential security issue generated either by Amazon Web
/// Services services or by the integrated third-party
/// solutions and standards checks.
pub const AwsSecurityFinding = struct {
    /// Provides details about an action that affects or that was taken on a
    /// resource.
    action: ?Action,

    /// The Amazon Web Services account ID that a finding is generated in.
    ///
    /// Length Constraints: 12.
    aws_account_id: []const u8,

    /// The name of the Amazon Web Services account from which a finding was
    /// generated.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 50.
    aws_account_name: ?[]const u8,

    /// The name of the company for the product that generated the finding.
    ///
    /// Security Hub populates this attribute automatically for each finding. You
    /// cannot update this attribute with `BatchImportFindings` or
    /// `BatchUpdateFindings`. The exception to this is a custom integration.
    ///
    /// When you use the Security Hub console or API to filter findings by company
    /// name, you use this attribute.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 128.
    company_name: ?[]const u8,

    /// This data type is exclusive to findings that are generated as the result of
    /// a check run
    /// against a specific rule in a supported security standard, such as CIS Amazon
    /// Web Services Foundations.
    /// Contains security standard-related finding details.
    compliance: ?Compliance,

    /// A finding's confidence. Confidence is defined as the likelihood that a
    /// finding
    /// accurately identifies the behavior or issue that it was intended to
    /// identify.
    ///
    /// Confidence is scored on a 0-100 basis using a ratio scale, where 0 means
    /// zero percent
    /// confidence and 100 means 100 percent confidence.
    confidence: ?i32,

    /// Indicates when the security findings provider created the potential security
    /// issue that
    /// a finding captured.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_at: []const u8,

    /// The level of importance assigned to the resources associated with the
    /// finding.
    ///
    /// A score of 0 means that the underlying resources have no criticality, and a
    /// score of 100
    /// is reserved for the most critical resources.
    criticality: ?i32,

    /// A finding's description. `Description` is a required property.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 1024.
    description: []const u8,

    /// Provides details about an Amazon GuardDuty Extended Threat Detection attack
    /// sequence. GuardDuty generates an attack
    /// sequence finding when multiple events align to a potentially suspicious
    /// activity. To receive GuardDuty attack sequence findings in Security Hub, you
    /// must have GuardDuty enabled. For more information, see [GuardDuty Extended
    /// Threat Detection
    /// ](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) in the *Amazon GuardDuty User Guide*.
    detection: ?Detection,

    /// In a `BatchImportFindings` request, finding providers use
    /// `FindingProviderFields` to provide and update their own values for
    /// confidence, criticality, related findings, severity, and types.
    finding_provider_fields: ?FindingProviderFields,

    /// Indicates when the security findings provider first observed the potential
    /// security
    /// issue that a finding captured.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    first_observed_at: ?[]const u8,

    /// Provides metadata for the Amazon CodeGuru detector associated with a
    /// finding. This field pertains to
    /// findings that relate to Lambda functions. Amazon Inspector identifies policy
    /// violations and
    /// vulnerabilities in Lambda function code based on internal detectors
    /// developed
    /// in collaboration with Amazon CodeGuru. Security Hub receives those findings.
    generator_details: ?GeneratorDetails,

    /// The identifier for the solution-specific component (a discrete unit of
    /// logic) that
    /// generated a finding. In various security findings providers' solutions, this
    /// generator can
    /// be called a rule, a check, a detector, a plugin, or something else.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 512.
    generator_id: []const u8,

    /// The security findings provider-specific identifier for a finding.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 512.
    id: []const u8,

    /// Indicates when the security findings provider most recently observed a
    /// change in the resource that is involved in the finding.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_observed_at: ?[]const u8,

    /// A list of malware related to a finding.
    ///
    /// Array Members: Maximum number of 5 items.
    malware: ?[]const Malware,

    /// The details of network-related information about a finding.
    network: ?Network,

    /// Provides information about a network path that is relevant to a finding.
    /// Each entry
    /// under `NetworkPath` represents a component of that path.
    network_path: ?[]const NetworkPathComponent,

    /// A user-defined note added to a finding.
    note: ?Note,

    /// Provides an overview of the patch compliance status for an instance against
    /// a selected
    /// compliance standard.
    patch_summary: ?PatchSummary,

    /// The details of process-related information about a finding.
    process: ?ProcessDetails,

    /// A timestamp that indicates when Security Hub received a finding and begins
    /// to process it.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    processed_at: ?[]const u8,

    /// The ARN generated by Security Hub that uniquely identifies a product that
    /// generates findings.
    /// This can be the ARN for a third-party product that is integrated with
    /// Security Hub, or the ARN for
    /// a custom integration.
    ///
    /// Length Constraints: Minimum length of 12. Maximum length of 2048.
    product_arn: []const u8,

    /// A data type where security findings providers can include additional
    /// solution-specific
    /// details that aren't part of the defined `AwsSecurityFinding` format.
    ///
    /// Can contain up to 50 key-value pairs. For each key-value pair, the key can
    /// contain up to 128 characters, and the value can contain up to 2048
    /// characters.
    product_fields: ?[]const aws.map.StringMapEntry,

    /// The name of the product that generated the finding.
    ///
    /// Security Hub populates this attribute automatically for each finding. You
    /// cannot update this attribute with `BatchImportFindings` or
    /// `BatchUpdateFindings`. The exception to this is a custom integration.
    ///
    /// When you use the Security Hub console or API to filter findings by product
    /// name, you use this attribute.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 128.
    product_name: ?[]const u8,

    /// The record state of a finding.
    record_state: ?RecordState,

    /// The Region from which the finding was generated.
    ///
    /// Security Hub populates this attribute automatically for each finding. You
    /// cannot update it using `BatchImportFindings` or `BatchUpdateFindings`.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 16.
    region: ?[]const u8,

    /// A list of related findings.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 10 items.
    related_findings: ?[]const RelatedFinding,

    /// A data type that describes the remediation options for a finding.
    remediation: ?Remediation,

    /// A set of resource data types that describe the resources that the finding
    /// refers
    /// to.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 32 items.
    resources: []const Resource,

    /// Indicates whether the finding is a sample finding.
    sample: ?bool,

    /// The schema version that a finding is formatted for. The value is
    /// `2018-10-08`.
    schema_version: []const u8,

    /// A finding's severity.
    severity: ?Severity,

    /// A URL that links to a page about the current finding in the security
    /// findings provider's
    /// solution.
    source_url: ?[]const u8,

    /// Threat intelligence details related to a finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 5 items.
    threat_intel_indicators: ?[]const ThreatIntelIndicator,

    /// Details about the threat detected in a security finding and the file paths
    /// that were affected by the threat.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 32 items.
    threats: ?[]const Threat,

    /// A finding's title. `Title` is a required property.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 256.
    title: []const u8,

    /// One or more finding types in the format of `namespace/category/classifier`
    /// that classify a finding.
    ///
    /// Valid namespace values are: Software and Configuration Checks | TTPs |
    /// Effects | Unusual
    /// Behaviors | Sensitive Data Identifications
    ///
    /// Array Members: Maximum number of 50 items.
    types: ?[]const []const u8,

    /// Indicates when the security findings provider last updated the finding
    /// record.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    updated_at: []const u8,

    /// A list of name/value string pairs associated with the finding. These are
    /// custom,
    /// user-defined fields added to a finding.
    ///
    /// Can contain up to 50 key-value pairs. For each key-value pair, the key can
    /// contain up to 128 characters, and the value can contain up to 1024
    /// characters.
    user_defined_fields: ?[]const aws.map.StringMapEntry,

    /// Indicates the veracity of a finding.
    verification_state: ?VerificationState,

    /// Provides a list of vulnerabilities associated with the findings.
    vulnerabilities: ?[]const Vulnerability,

    /// Provides information about the status of the investigation into a finding.
    workflow: ?Workflow,

    /// The workflow state of a finding.
    workflow_state: ?WorkflowState,

    pub const json_field_names = .{
        .action = "Action",
        .aws_account_id = "AwsAccountId",
        .aws_account_name = "AwsAccountName",
        .company_name = "CompanyName",
        .compliance = "Compliance",
        .confidence = "Confidence",
        .created_at = "CreatedAt",
        .criticality = "Criticality",
        .description = "Description",
        .detection = "Detection",
        .finding_provider_fields = "FindingProviderFields",
        .first_observed_at = "FirstObservedAt",
        .generator_details = "GeneratorDetails",
        .generator_id = "GeneratorId",
        .id = "Id",
        .last_observed_at = "LastObservedAt",
        .malware = "Malware",
        .network = "Network",
        .network_path = "NetworkPath",
        .note = "Note",
        .patch_summary = "PatchSummary",
        .process = "Process",
        .processed_at = "ProcessedAt",
        .product_arn = "ProductArn",
        .product_fields = "ProductFields",
        .product_name = "ProductName",
        .record_state = "RecordState",
        .region = "Region",
        .related_findings = "RelatedFindings",
        .remediation = "Remediation",
        .resources = "Resources",
        .sample = "Sample",
        .schema_version = "SchemaVersion",
        .severity = "Severity",
        .source_url = "SourceUrl",
        .threat_intel_indicators = "ThreatIntelIndicators",
        .threats = "Threats",
        .title = "Title",
        .types = "Types",
        .updated_at = "UpdatedAt",
        .user_defined_fields = "UserDefinedFields",
        .verification_state = "VerificationState",
        .vulnerabilities = "Vulnerabilities",
        .workflow = "Workflow",
        .workflow_state = "WorkflowState",
    };
};
