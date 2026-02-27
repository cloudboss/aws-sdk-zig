const StringFilter = @import("string_filter.zig").StringFilter;
const NumberFilter = @import("number_filter.zig").NumberFilter;
const DateFilter = @import("date_filter.zig").DateFilter;
const MapFilter = @import("map_filter.zig").MapFilter;

/// The criteria that determine which findings a rule applies to.
pub const AutomationRulesFindingFilters = struct {
    /// The Amazon Web Services account ID in which a finding was generated.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 100 items.
    aws_account_id: ?[]const StringFilter,

    /// The name of the Amazon Web Services account in which a finding was
    /// generated.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    aws_account_name: ?[]const StringFilter,

    /// The name of the company for the product that generated the finding.
    /// For control-based findings, the company is Amazon Web Services.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    company_name: ?[]const StringFilter,

    /// The unique identifier of a standard in which a control is enabled. This
    /// field consists of the resource portion of
    /// the Amazon Resource Name (ARN) returned for a standard in the
    /// [DescribeStandards](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_DescribeStandards.html) API response.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    compliance_associated_standards_id: ?[]const StringFilter,

    /// The security control ID for which a finding was generated. Security control
    /// IDs are the same across standards.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    compliance_security_control_id: ?[]const StringFilter,

    /// The result of a security check. This field is only used for findings
    /// generated
    /// from controls.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    compliance_status: ?[]const StringFilter,

    /// The likelihood that a finding accurately identifies the behavior or issue
    /// that it was
    /// intended to identify. `Confidence` is scored on a 0–100 basis using a ratio
    /// scale. A value of `0` means 0 percent confidence, and a value of
    /// `100` means 100 percent confidence. For example, a data exfiltration
    /// detection based on a statistical deviation of network traffic has low
    /// confidence because an
    /// actual exfiltration hasn't been verified. For more information, see
    /// [Confidence](https://docs.aws.amazon.com/securityhub/latest/userguide/asff-top-level-attributes.html#asff-confidence) in the *Security Hub User Guide*.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    confidence: ?[]const NumberFilter,

    /// A timestamp that indicates when this finding record was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    created_at: ?[]const DateFilter,

    /// The level of importance that is assigned to the resources that are
    /// associated with a
    /// finding. `Criticality` is scored on a 0–100 basis, using a ratio scale that
    /// supports
    /// only full integers. A score of `0` means that the underlying resources have
    /// no
    /// criticality, and a score of `100` is reserved for the most critical
    /// resources. For
    /// more information, see
    /// [Criticality](https://docs.aws.amazon.com/securityhub/latest/userguide/asff-top-level-attributes.html#asff-criticality) in the *Security Hub User Guide*.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    criticality: ?[]const NumberFilter,

    /// A finding's description.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    description: ?[]const StringFilter,

    /// A timestamp that indicates when the potential security issue captured by a
    /// finding was first observed by the security findings product.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    first_observed_at: ?[]const DateFilter,

    /// The identifier for the solution-specific component that
    /// generated a finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 100 items.
    generator_id: ?[]const StringFilter,

    /// The product-specific identifier for a finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    id: ?[]const StringFilter,

    /// A timestamp that indicates when the security findings provider most recently
    /// observed a change in the resource that is involved in the finding.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    last_observed_at: ?[]const DateFilter,

    /// The text of a user-defined note that's added to a finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    note_text: ?[]const StringFilter,

    /// The timestamp of when the note was updated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    note_updated_at: ?[]const DateFilter,

    /// The principal that created a note.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    note_updated_by: ?[]const StringFilter,

    /// The Amazon Resource Name (ARN) for a third-party product that generated a
    /// finding in
    /// Security Hub.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    product_arn: ?[]const StringFilter,

    /// Provides the name of the product that generated the finding. For
    /// control-based findings, the product name is Security Hub.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    product_name: ?[]const StringFilter,

    /// Provides the current state of a finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    record_state: ?[]const StringFilter,

    /// The product-generated identifier for a related finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    related_findings_id: ?[]const StringFilter,

    /// The ARN for the product that generated a related finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    related_findings_product_arn: ?[]const StringFilter,

    /// The Amazon Resource Name (ARN) of the application that is related to a
    /// finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    resource_application_arn: ?[]const StringFilter,

    /// The name of the application that is related to a finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    resource_application_name: ?[]const StringFilter,

    /// Custom fields and values about the resource that a finding pertains to.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    resource_details_other: ?[]const MapFilter,

    /// The identifier for the given resource type. For Amazon Web Services
    /// resources that are identified by
    /// Amazon Resource Names (ARNs), this is the ARN. For Amazon Web Services
    /// resources that lack ARNs,
    /// this is the identifier as defined by the Amazon Web Services service that
    /// created the resource.
    /// For non-Amazon Web Services resources, this is a unique identifier that is
    /// associated with the
    /// resource.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 100 items.
    resource_id: ?[]const StringFilter,

    /// The partition in which the resource that the finding pertains to is located.
    /// A partition is a group of Amazon Web Services Regions. Each Amazon Web
    /// Services account is scoped to one partition.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    resource_partition: ?[]const StringFilter,

    /// The Amazon Web Services Region where the resource that a finding pertains to
    /// is located.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    resource_region: ?[]const StringFilter,

    /// A list of Amazon Web Services tags associated with a resource at the time
    /// the finding was processed.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    resource_tags: ?[]const MapFilter,

    /// The type of resource that the finding pertains to.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    resource_type: ?[]const StringFilter,

    /// The severity value of the finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    severity_label: ?[]const StringFilter,

    /// Provides a URL that links to a page about the current finding in the finding
    /// product.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    source_url: ?[]const StringFilter,

    /// A finding's title.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 100 items.
    title: ?[]const StringFilter,

    /// One or more finding types in the format of namespace/category/classifier
    /// that classify
    /// a finding. For a list of namespaces, classifiers, and categories, see [Types
    /// taxonomy for
    /// ASFF](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-findings-format-type-taxonomy.html) in the *Security Hub User Guide*.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    type: ?[]const StringFilter,

    /// A timestamp that indicates when the finding record was most recently
    /// updated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    updated_at: ?[]const DateFilter,

    /// A list of user-defined name and value string pairs added to a finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    user_defined_fields: ?[]const MapFilter,

    /// Provides the veracity of a finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    verification_state: ?[]const StringFilter,

    /// Provides information about the status of the investigation into a finding.
    ///
    /// Array Members: Minimum number of 1 item. Maximum number of 20 items.
    workflow_status: ?[]const StringFilter,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .aws_account_name = "AwsAccountName",
        .company_name = "CompanyName",
        .compliance_associated_standards_id = "ComplianceAssociatedStandardsId",
        .compliance_security_control_id = "ComplianceSecurityControlId",
        .compliance_status = "ComplianceStatus",
        .confidence = "Confidence",
        .created_at = "CreatedAt",
        .criticality = "Criticality",
        .description = "Description",
        .first_observed_at = "FirstObservedAt",
        .generator_id = "GeneratorId",
        .id = "Id",
        .last_observed_at = "LastObservedAt",
        .note_text = "NoteText",
        .note_updated_at = "NoteUpdatedAt",
        .note_updated_by = "NoteUpdatedBy",
        .product_arn = "ProductArn",
        .product_name = "ProductName",
        .record_state = "RecordState",
        .related_findings_id = "RelatedFindingsId",
        .related_findings_product_arn = "RelatedFindingsProductArn",
        .resource_application_arn = "ResourceApplicationArn",
        .resource_application_name = "ResourceApplicationName",
        .resource_details_other = "ResourceDetailsOther",
        .resource_id = "ResourceId",
        .resource_partition = "ResourcePartition",
        .resource_region = "ResourceRegion",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
        .severity_label = "SeverityLabel",
        .source_url = "SourceUrl",
        .title = "Title",
        .type = "Type",
        .updated_at = "UpdatedAt",
        .user_defined_fields = "UserDefinedFields",
        .verification_state = "VerificationState",
        .workflow_status = "WorkflowStatus",
    };
};
