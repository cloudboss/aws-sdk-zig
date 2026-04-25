const StringFilter = @import("string_filter.zig").StringFilter;
const NumberFilter = @import("number_filter.zig").NumberFilter;
const DateFilter = @import("date_filter.zig").DateFilter;
const KeywordFilter = @import("keyword_filter.zig").KeywordFilter;
const IpFilter = @import("ip_filter.zig").IpFilter;
const MapFilter = @import("map_filter.zig").MapFilter;
const BooleanFilter = @import("boolean_filter.zig").BooleanFilter;

/// A collection of filters that are applied to all active findings aggregated
/// by Security Hub CSPM.
///
/// You can filter by up to ten finding attributes. For each attribute, you can
/// provide up to
/// 20 filter values.
pub const AwsSecurityFindingFilters = struct {
    /// The Amazon Web Services account ID in which a finding is generated.
    aws_account_id: ?[]const StringFilter = null,

    /// The name of the Amazon Web Services account in which a finding is generated.
    aws_account_name: ?[]const StringFilter = null,

    /// The name of the findings provider (company) that owns the solution (product)
    /// that
    /// generates findings.
    company_name: ?[]const StringFilter = null,

    /// The unique identifier of a standard in which a control is enabled. This
    /// field consists of the resource portion of the
    /// Amazon Resource Name (ARN) returned for a standard in the
    /// [DescribeStandards](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_DescribeStandards.html) API response.
    compliance_associated_standards_id: ?[]const StringFilter = null,

    /// The unique identifier of a control across standards. Values for this field
    /// typically consist of an
    /// Amazon Web Services service and a number, such as APIGateway.5.
    compliance_security_control_id: ?[]const StringFilter = null,

    /// The name of a security control parameter.
    compliance_security_control_parameters_name: ?[]const StringFilter = null,

    /// The current value of a security control parameter.
    compliance_security_control_parameters_value: ?[]const StringFilter = null,

    /// Exclusive to findings that are generated as the result of a check run
    /// against a specific
    /// rule in a supported standard, such as CIS Amazon Web Services Foundations.
    /// Contains security
    /// standard-related finding details.
    compliance_status: ?[]const StringFilter = null,

    /// A finding's confidence. Confidence is defined as the likelihood that a
    /// finding
    /// accurately identifies the behavior or issue that it was intended to
    /// identify.
    ///
    /// Confidence is scored on a 0-100 basis using a ratio scale, where 0 means
    /// zero percent
    /// confidence and 100 means 100 percent confidence.
    confidence: ?[]const NumberFilter = null,

    /// A timestamp that indicates when the security findings provider
    /// created the potential security issue that a finding reflects.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_at: ?[]const DateFilter = null,

    /// The level of importance assigned to the resources associated with the
    /// finding.
    ///
    /// A score of 0 means that the underlying resources have no criticality, and a
    /// score of 100
    /// is reserved for the most critical resources.
    criticality: ?[]const NumberFilter = null,

    /// A finding's description.
    description: ?[]const StringFilter = null,

    /// The finding provider value for the finding confidence. Confidence is defined
    /// as the likelihood
    /// that a finding accurately identifies the behavior or issue that it was
    /// intended to
    /// identify.
    ///
    /// Confidence is scored on a 0-100 basis using a ratio scale, where 0 means
    /// zero percent
    /// confidence and 100 means 100 percent confidence.
    finding_provider_fields_confidence: ?[]const NumberFilter = null,

    /// The finding provider value for the level of importance assigned to the
    /// resources associated with
    /// the findings.
    ///
    /// A score of 0 means that the underlying resources have no criticality, and a
    /// score of 100
    /// is reserved for the most critical resources.
    finding_provider_fields_criticality: ?[]const NumberFilter = null,

    /// The finding identifier of a related finding that is identified by the
    /// finding provider.
    finding_provider_fields_related_findings_id: ?[]const StringFilter = null,

    /// The ARN of the solution that generated a related finding that is identified
    /// by the finding provider.
    finding_provider_fields_related_findings_product_arn: ?[]const StringFilter = null,

    /// The finding provider value for the severity label.
    finding_provider_fields_severity_label: ?[]const StringFilter = null,

    /// The finding provider's original value for the severity.
    finding_provider_fields_severity_original: ?[]const StringFilter = null,

    /// One or more finding types that the finding provider assigned to the finding.
    /// Uses the format of `namespace/category/classifier`
    /// that classify a finding.
    ///
    /// Valid namespace values are: Software and Configuration Checks | TTPs |
    /// Effects | Unusual
    /// Behaviors | Sensitive Data Identifications
    finding_provider_fields_types: ?[]const StringFilter = null,

    /// A timestamp that indicates when the security findings provider first
    /// observed the potential security issue that a finding captured.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    first_observed_at: ?[]const DateFilter = null,

    /// The identifier for the solution-specific component (a discrete unit of
    /// logic) that
    /// generated a finding. In various security findings providers' solutions, this
    /// generator can
    /// be called a rule, a check, a detector, a plugin, etc.
    generator_id: ?[]const StringFilter = null,

    /// The security findings provider-specific identifier for a finding.
    id: ?[]const StringFilter = null,

    /// A keyword for a finding.
    keyword: ?[]const KeywordFilter = null,

    /// A timestamp that indicates when the security findings provider most recently
    /// observed a change in the resource that is involved in the finding.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_observed_at: ?[]const DateFilter = null,

    /// The name of the malware that was observed.
    malware_name: ?[]const StringFilter = null,

    /// The filesystem path of the malware that was observed.
    malware_path: ?[]const StringFilter = null,

    /// The state of the malware that was observed.
    malware_state: ?[]const StringFilter = null,

    /// The type of the malware that was observed.
    malware_type: ?[]const StringFilter = null,

    /// The destination domain of network-related information about a finding.
    network_destination_domain: ?[]const StringFilter = null,

    /// The destination IPv4 address of network-related information about a finding.
    network_destination_ip_v4: ?[]const IpFilter = null,

    /// The destination IPv6 address of network-related information about a finding.
    network_destination_ip_v6: ?[]const IpFilter = null,

    /// The destination port of network-related information about a finding.
    network_destination_port: ?[]const NumberFilter = null,

    /// Indicates the direction of network traffic associated with a finding.
    network_direction: ?[]const StringFilter = null,

    /// The protocol of network-related information about a finding.
    network_protocol: ?[]const StringFilter = null,

    /// The source domain of network-related information about a finding.
    network_source_domain: ?[]const StringFilter = null,

    /// The source IPv4 address of network-related information about a finding.
    network_source_ip_v4: ?[]const IpFilter = null,

    /// The source IPv6 address of network-related information about a finding.
    network_source_ip_v6: ?[]const IpFilter = null,

    /// The source media access control (MAC) address of network-related information
    /// about a
    /// finding.
    network_source_mac: ?[]const StringFilter = null,

    /// The source port of network-related information about a finding.
    network_source_port: ?[]const NumberFilter = null,

    /// The text of a note.
    note_text: ?[]const StringFilter = null,

    /// The timestamp of when the note was updated.
    note_updated_at: ?[]const DateFilter = null,

    /// The principal that created a note.
    note_updated_by: ?[]const StringFilter = null,

    /// A timestamp that identifies when the process was launched.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    process_launched_at: ?[]const DateFilter = null,

    /// The name of the process.
    process_name: ?[]const StringFilter = null,

    /// The parent process ID. This field accepts positive integers between `O` and
    /// `2147483647`.
    process_parent_pid: ?[]const NumberFilter = null,

    /// The path to the process executable.
    process_path: ?[]const StringFilter = null,

    /// The process ID.
    process_pid: ?[]const NumberFilter = null,

    /// A timestamp that identifies when the process was terminated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    process_terminated_at: ?[]const DateFilter = null,

    /// The ARN generated by Security Hub CSPM that uniquely identifies a
    /// third-party company
    /// (security findings provider) after this provider's product (solution that
    /// generates
    /// findings) is registered with Security Hub CSPM.
    product_arn: ?[]const StringFilter = null,

    /// A data type where security findings providers can include additional
    /// solution-specific
    /// details that aren't part of the defined `AwsSecurityFinding` format.
    product_fields: ?[]const MapFilter = null,

    /// The name of the solution (product) that generates findings.
    product_name: ?[]const StringFilter = null,

    /// The recommendation of what to do about the issue described in a finding.
    recommendation_text: ?[]const StringFilter = null,

    /// The updated record state for the finding.
    record_state: ?[]const StringFilter = null,

    /// The Region from which the finding was generated.
    region: ?[]const StringFilter = null,

    /// The solution-generated identifier for a related finding.
    related_findings_id: ?[]const StringFilter = null,

    /// The ARN of the solution that generated a related finding.
    related_findings_product_arn: ?[]const StringFilter = null,

    /// The ARN of the application that is related to a finding.
    resource_application_arn: ?[]const StringFilter = null,

    /// The name of the application that is related to a finding.
    resource_application_name: ?[]const StringFilter = null,

    /// The IAM profile ARN of the instance.
    resource_aws_ec_2_instance_iam_instance_profile_arn: ?[]const StringFilter = null,

    /// The Amazon Machine Image (AMI) ID of the instance.
    resource_aws_ec_2_instance_image_id: ?[]const StringFilter = null,

    /// The IPv4 addresses associated with the instance.
    resource_aws_ec_2_instance_ip_v4_addresses: ?[]const IpFilter = null,

    /// The IPv6 addresses associated with the instance.
    resource_aws_ec_2_instance_ip_v6_addresses: ?[]const IpFilter = null,

    /// The key name associated with the instance.
    resource_aws_ec_2_instance_key_name: ?[]const StringFilter = null,

    /// The date and time the instance was launched.
    resource_aws_ec_2_instance_launched_at: ?[]const DateFilter = null,

    /// The identifier of the subnet that the instance was launched in.
    resource_aws_ec_2_instance_subnet_id: ?[]const StringFilter = null,

    /// The instance type of the instance.
    resource_aws_ec_2_instance_type: ?[]const StringFilter = null,

    /// The identifier of the VPC that the instance was launched in.
    resource_aws_ec_2_instance_vpc_id: ?[]const StringFilter = null,

    /// The creation date/time of the IAM access key related to a finding.
    resource_aws_iam_access_key_created_at: ?[]const DateFilter = null,

    /// The name of the principal that is associated with an IAM access key.
    resource_aws_iam_access_key_principal_name: ?[]const StringFilter = null,

    /// The status of the IAM access key related to a finding.
    resource_aws_iam_access_key_status: ?[]const StringFilter = null,

    /// The user associated with the IAM access key related to a finding.
    resource_aws_iam_access_key_user_name: ?[]const StringFilter = null,

    /// The name of an IAM user.
    resource_aws_iam_user_user_name: ?[]const StringFilter = null,

    /// The canonical user ID of the owner of the S3 bucket.
    resource_aws_s3_bucket_owner_id: ?[]const StringFilter = null,

    /// The display name of the owner of the S3 bucket.
    resource_aws_s3_bucket_owner_name: ?[]const StringFilter = null,

    /// The identifier of the image related to a finding.
    resource_container_image_id: ?[]const StringFilter = null,

    /// The name of the image related to a finding.
    resource_container_image_name: ?[]const StringFilter = null,

    /// A timestamp that identifies when the container was started.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    resource_container_launched_at: ?[]const DateFilter = null,

    /// The name of the container related to a finding.
    resource_container_name: ?[]const StringFilter = null,

    /// The details of a resource that doesn't have a specific subfield for the
    /// resource type
    /// defined.
    resource_details_other: ?[]const MapFilter = null,

    /// The canonical identifier for the given resource type.
    resource_id: ?[]const StringFilter = null,

    /// The canonical Amazon Web Services partition name that the Region is assigned
    /// to.
    resource_partition: ?[]const StringFilter = null,

    /// The canonical Amazon Web Services external Region name where this resource
    /// is located.
    resource_region: ?[]const StringFilter = null,

    /// A list of Amazon Web Services tags associated with a resource at the time
    /// the finding was
    /// processed.
    resource_tags: ?[]const MapFilter = null,

    /// Specifies the type of the resource that details are provided for.
    resource_type: ?[]const StringFilter = null,

    /// Indicates whether or not sample findings are included in the filter results.
    sample: ?[]const BooleanFilter = null,

    /// The label of a finding's severity.
    severity_label: ?[]const StringFilter = null,

    /// The normalized severity of a finding.
    severity_normalized: ?[]const NumberFilter = null,

    /// The native severity as defined by the security findings provider's solution
    /// that
    /// generated the finding.
    severity_product: ?[]const NumberFilter = null,

    /// A URL that links to a page about the current finding in the security
    /// findings provider's
    /// solution.
    source_url: ?[]const StringFilter = null,

    /// The category of a threat intelligence indicator.
    threat_intel_indicator_category: ?[]const StringFilter = null,

    /// A timestamp that identifies the last observation of a threat intelligence
    /// indicator.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    threat_intel_indicator_last_observed_at: ?[]const DateFilter = null,

    /// The source of the threat intelligence.
    threat_intel_indicator_source: ?[]const StringFilter = null,

    /// The URL for more details from the source of the threat intelligence.
    threat_intel_indicator_source_url: ?[]const StringFilter = null,

    /// The type of a threat intelligence indicator.
    threat_intel_indicator_type: ?[]const StringFilter = null,

    /// The value of a threat intelligence indicator.
    threat_intel_indicator_value: ?[]const StringFilter = null,

    /// A finding's title.
    title: ?[]const StringFilter = null,

    /// A finding type in the format of `namespace/category/classifier` that
    /// classifies a finding.
    @"type": ?[]const StringFilter = null,

    /// A timestamp that indicates when the security findings provider last
    /// updated the finding record.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    updated_at: ?[]const DateFilter = null,

    /// A list of name/value string pairs associated with the finding. These are
    /// custom,
    /// user-defined fields added to a finding.
    user_defined_fields: ?[]const MapFilter = null,

    /// The veracity of a finding.
    verification_state: ?[]const StringFilter = null,

    /// Indicates whether a software vulnerability in your environment has a known
    /// exploit. You can filter findings by this
    /// field only if you use Security Hub CSPM and Amazon Inspector.
    vulnerabilities_exploit_available: ?[]const StringFilter = null,

    /// Indicates whether a vulnerability is fixed in a newer version of the
    /// affected software packages. You can filter
    /// findings by this field only if you use Security Hub CSPM and Amazon
    /// Inspector.
    vulnerabilities_fix_available: ?[]const StringFilter = null,

    /// The workflow state of a finding.
    ///
    /// Note that this field is deprecated. To search for a finding based on its
    /// workflow
    /// status, use `WorkflowStatus`.
    workflow_state: ?[]const StringFilter = null,

    /// The status of the investigation into a finding. Allowed values are the
    /// following.
    ///
    /// * `NEW` - The initial state of a finding, before it is reviewed.
    ///
    /// Security Hub CSPM also resets the workflow status from `NOTIFIED` or
    /// `RESOLVED` to `NEW` in the following cases:
    ///
    /// * `RecordState` changes from `ARCHIVED` to `ACTIVE`.
    ///
    /// * `Compliance.Status` changes from `PASSED` to either `WARNING`,
    /// `FAILED`, or `NOT_AVAILABLE`.
    ///
    /// * `NOTIFIED` - Indicates that the resource owner has been notified about
    /// the security issue. Used when the initial reviewer is not the resource
    /// owner, and
    /// needs intervention from the resource owner.
    ///
    /// If one of the following occurs, the workflow status is changed automatically
    /// from
    /// `NOTIFIED` to `NEW`:
    ///
    /// * `RecordState` changes from `ARCHIVED` to
    /// `ACTIVE`.
    ///
    /// * `Compliance.Status` changes from `PASSED` to `FAILED`,
    /// `WARNING`, or `NOT_AVAILABLE`.
    ///
    /// * `SUPPRESSED` - Indicates that you reviewed the finding and don't believe
    ///   that any action is
    /// needed.
    ///
    /// The workflow status of a `SUPPRESSED` finding does not change if
    /// `RecordState` changes from `ARCHIVED` to
    /// `ACTIVE`.
    ///
    /// * `RESOLVED` - The finding was reviewed and remediated and is now
    /// considered resolved.
    ///
    /// The finding remains `RESOLVED` unless one of the following occurs:
    ///
    /// * `RecordState` changes from `ARCHIVED` to
    /// `ACTIVE`.
    ///
    /// * `Compliance.Status` changes from `PASSED` to `FAILED`,
    /// `WARNING`, or `NOT_AVAILABLE`.
    ///
    /// In those cases, the workflow status is automatically reset to `NEW`.
    ///
    /// For findings from controls, if `Compliance.Status` is `PASSED`,
    /// then Security Hub CSPM automatically sets the workflow status to `RESOLVED`.
    workflow_status: ?[]const StringFilter = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .aws_account_name = "AwsAccountName",
        .company_name = "CompanyName",
        .compliance_associated_standards_id = "ComplianceAssociatedStandardsId",
        .compliance_security_control_id = "ComplianceSecurityControlId",
        .compliance_security_control_parameters_name = "ComplianceSecurityControlParametersName",
        .compliance_security_control_parameters_value = "ComplianceSecurityControlParametersValue",
        .compliance_status = "ComplianceStatus",
        .confidence = "Confidence",
        .created_at = "CreatedAt",
        .criticality = "Criticality",
        .description = "Description",
        .finding_provider_fields_confidence = "FindingProviderFieldsConfidence",
        .finding_provider_fields_criticality = "FindingProviderFieldsCriticality",
        .finding_provider_fields_related_findings_id = "FindingProviderFieldsRelatedFindingsId",
        .finding_provider_fields_related_findings_product_arn = "FindingProviderFieldsRelatedFindingsProductArn",
        .finding_provider_fields_severity_label = "FindingProviderFieldsSeverityLabel",
        .finding_provider_fields_severity_original = "FindingProviderFieldsSeverityOriginal",
        .finding_provider_fields_types = "FindingProviderFieldsTypes",
        .first_observed_at = "FirstObservedAt",
        .generator_id = "GeneratorId",
        .id = "Id",
        .keyword = "Keyword",
        .last_observed_at = "LastObservedAt",
        .malware_name = "MalwareName",
        .malware_path = "MalwarePath",
        .malware_state = "MalwareState",
        .malware_type = "MalwareType",
        .network_destination_domain = "NetworkDestinationDomain",
        .network_destination_ip_v4 = "NetworkDestinationIpV4",
        .network_destination_ip_v6 = "NetworkDestinationIpV6",
        .network_destination_port = "NetworkDestinationPort",
        .network_direction = "NetworkDirection",
        .network_protocol = "NetworkProtocol",
        .network_source_domain = "NetworkSourceDomain",
        .network_source_ip_v4 = "NetworkSourceIpV4",
        .network_source_ip_v6 = "NetworkSourceIpV6",
        .network_source_mac = "NetworkSourceMac",
        .network_source_port = "NetworkSourcePort",
        .note_text = "NoteText",
        .note_updated_at = "NoteUpdatedAt",
        .note_updated_by = "NoteUpdatedBy",
        .process_launched_at = "ProcessLaunchedAt",
        .process_name = "ProcessName",
        .process_parent_pid = "ProcessParentPid",
        .process_path = "ProcessPath",
        .process_pid = "ProcessPid",
        .process_terminated_at = "ProcessTerminatedAt",
        .product_arn = "ProductArn",
        .product_fields = "ProductFields",
        .product_name = "ProductName",
        .recommendation_text = "RecommendationText",
        .record_state = "RecordState",
        .region = "Region",
        .related_findings_id = "RelatedFindingsId",
        .related_findings_product_arn = "RelatedFindingsProductArn",
        .resource_application_arn = "ResourceApplicationArn",
        .resource_application_name = "ResourceApplicationName",
        .resource_aws_ec_2_instance_iam_instance_profile_arn = "ResourceAwsEc2InstanceIamInstanceProfileArn",
        .resource_aws_ec_2_instance_image_id = "ResourceAwsEc2InstanceImageId",
        .resource_aws_ec_2_instance_ip_v4_addresses = "ResourceAwsEc2InstanceIpV4Addresses",
        .resource_aws_ec_2_instance_ip_v6_addresses = "ResourceAwsEc2InstanceIpV6Addresses",
        .resource_aws_ec_2_instance_key_name = "ResourceAwsEc2InstanceKeyName",
        .resource_aws_ec_2_instance_launched_at = "ResourceAwsEc2InstanceLaunchedAt",
        .resource_aws_ec_2_instance_subnet_id = "ResourceAwsEc2InstanceSubnetId",
        .resource_aws_ec_2_instance_type = "ResourceAwsEc2InstanceType",
        .resource_aws_ec_2_instance_vpc_id = "ResourceAwsEc2InstanceVpcId",
        .resource_aws_iam_access_key_created_at = "ResourceAwsIamAccessKeyCreatedAt",
        .resource_aws_iam_access_key_principal_name = "ResourceAwsIamAccessKeyPrincipalName",
        .resource_aws_iam_access_key_status = "ResourceAwsIamAccessKeyStatus",
        .resource_aws_iam_access_key_user_name = "ResourceAwsIamAccessKeyUserName",
        .resource_aws_iam_user_user_name = "ResourceAwsIamUserUserName",
        .resource_aws_s3_bucket_owner_id = "ResourceAwsS3BucketOwnerId",
        .resource_aws_s3_bucket_owner_name = "ResourceAwsS3BucketOwnerName",
        .resource_container_image_id = "ResourceContainerImageId",
        .resource_container_image_name = "ResourceContainerImageName",
        .resource_container_launched_at = "ResourceContainerLaunchedAt",
        .resource_container_name = "ResourceContainerName",
        .resource_details_other = "ResourceDetailsOther",
        .resource_id = "ResourceId",
        .resource_partition = "ResourcePartition",
        .resource_region = "ResourceRegion",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
        .sample = "Sample",
        .severity_label = "SeverityLabel",
        .severity_normalized = "SeverityNormalized",
        .severity_product = "SeverityProduct",
        .source_url = "SourceUrl",
        .threat_intel_indicator_category = "ThreatIntelIndicatorCategory",
        .threat_intel_indicator_last_observed_at = "ThreatIntelIndicatorLastObservedAt",
        .threat_intel_indicator_source = "ThreatIntelIndicatorSource",
        .threat_intel_indicator_source_url = "ThreatIntelIndicatorSourceUrl",
        .threat_intel_indicator_type = "ThreatIntelIndicatorType",
        .threat_intel_indicator_value = "ThreatIntelIndicatorValue",
        .title = "Title",
        .@"type" = "Type",
        .updated_at = "UpdatedAt",
        .user_defined_fields = "UserDefinedFields",
        .verification_state = "VerificationState",
        .vulnerabilities_exploit_available = "VulnerabilitiesExploitAvailable",
        .vulnerabilities_fix_available = "VulnerabilitiesFixAvailable",
        .workflow_state = "WorkflowState",
        .workflow_status = "WorkflowStatus",
    };
};
