const aws = @import("aws");

const AdvancedSecurityOptions = @import("advanced_security_options.zig").AdvancedSecurityOptions;
const AIMLOptionsOutput = @import("aiml_options_output.zig").AIMLOptionsOutput;
const AutoTuneOptionsOutput = @import("auto_tune_options_output.zig").AutoTuneOptionsOutput;
const ChangeProgressDetails = @import("change_progress_details.zig").ChangeProgressDetails;
const ClusterConfig = @import("cluster_config.zig").ClusterConfig;
const CognitoOptions = @import("cognito_options.zig").CognitoOptions;
const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const DomainProcessingStatusType = @import("domain_processing_status_type.zig").DomainProcessingStatusType;
const EBSOptions = @import("ebs_options.zig").EBSOptions;
const EncryptionAtRestOptions = @import("encryption_at_rest_options.zig").EncryptionAtRestOptions;
const IdentityCenterOptions = @import("identity_center_options.zig").IdentityCenterOptions;
const IPAddressType = @import("ip_address_type.zig").IPAddressType;
const LogPublishingOption = @import("log_publishing_option.zig").LogPublishingOption;
const ModifyingProperties = @import("modifying_properties.zig").ModifyingProperties;
const NodeToNodeEncryptionOptions = @import("node_to_node_encryption_options.zig").NodeToNodeEncryptionOptions;
const OffPeakWindowOptions = @import("off_peak_window_options.zig").OffPeakWindowOptions;
const ServiceSoftwareOptions = @import("service_software_options.zig").ServiceSoftwareOptions;
const SnapshotOptions = @import("snapshot_options.zig").SnapshotOptions;
const SoftwareUpdateOptions = @import("software_update_options.zig").SoftwareUpdateOptions;
const VPCDerivedInfo = @import("vpc_derived_info.zig").VPCDerivedInfo;

/// The current status of an OpenSearch Service domain.
pub const DomainStatus = struct {
    /// Identity and Access Management (IAM) policy document specifying the access
    /// policies for the
    /// domain.
    access_policies: ?[]const u8,

    /// Key-value pairs that specify advanced configuration options.
    advanced_options: ?[]const aws.map.StringMapEntry,

    /// Settings for fine-grained access control.
    advanced_security_options: ?AdvancedSecurityOptions,

    /// Container for parameters required to enable all machine learning features.
    aiml_options: ?AIMLOptionsOutput,

    /// The Amazon Resource Name (ARN) of the domain. For more information, see [IAM
    /// identifiers
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html) in the *Amazon Web Services Identity and Access Management User Guide*.
    arn: []const u8,

    /// Auto-Tune settings for the domain.
    auto_tune_options: ?AutoTuneOptionsOutput,

    /// Information about a configuration change happening on the domain.
    change_progress_details: ?ChangeProgressDetails,

    /// Container for the cluster configuration of the domain.
    cluster_config: ClusterConfig,

    /// Key-value pairs to configure Amazon Cognito authentication for OpenSearch
    /// Dashboards.
    cognito_options: ?CognitoOptions,

    /// Creation status of an OpenSearch Service domain. True if domain creation is
    /// complete. False
    /// if domain creation is still in progress.
    created: ?bool,

    /// Deletion status of an OpenSearch Service domain. True if domain deletion is
    /// complete. False
    /// if domain deletion is still in progress. Once deletion is complete, the
    /// status of the domain is
    /// no longer returned.
    deleted: ?bool,

    /// Additional options for the domain endpoint, such as whether to require HTTPS
    /// for all
    /// traffic.
    domain_endpoint_options: ?DomainEndpointOptions,

    /// The dual stack hosted zone ID for the domain.
    domain_endpoint_v2_hosted_zone_id: ?[]const u8,

    /// Unique identifier for the domain.
    domain_id: []const u8,

    /// Name of the domain. Domain names are unique across all domains owned by the
    /// same account
    /// within an Amazon Web Services Region.
    domain_name: []const u8,

    /// The status of any changes that are currently in progress for the domain.
    domain_processing_status: ?DomainProcessingStatusType,

    /// Container for EBS-based storage settings for the domain.
    ebs_options: ?EBSOptions,

    /// Encryption at rest settings for the domain.
    encryption_at_rest_options: ?EncryptionAtRestOptions,

    /// Domain-specific endpoint used to submit index, search, and data upload
    /// requests to the
    /// domain.
    endpoint: ?[]const u8,

    /// The key-value pair that exists if the OpenSearch Service domain uses VPC
    /// endpoints. For
    /// example:
    ///
    /// * **IPv4 IP addresses** -
    /// `'vpc','vpc-endpoint-h2dsd34efgyghrtguk5gt6j2foh4.us-east-1.es.amazonaws.com'`
    ///
    /// * **Dual stack IP addresses** -
    /// `'vpcv2':'vpc-endpoint-h2dsd34efgyghrtguk5gt6j2foh4.aos.us-east-1.on.aws'`
    endpoints: ?[]const aws.map.StringMapEntry,

    /// If `IPAddressType` to set to `dualstack`, a version 2 domain endpoint
    /// is provisioned. This endpoint functions like a normal endpoint, except that
    /// it works with both
    /// IPv4 and IPv6 IP addresses. Normal endpoints work only with IPv4 IP
    /// addresses.
    endpoint_v2: ?[]const u8,

    /// Version of OpenSearch or Elasticsearch that the domain is running, in the
    /// format
    /// `Elasticsearch_X.Y` or `OpenSearch_X.Y`.
    engine_version: ?[]const u8,

    /// Configuration options for controlling IAM Identity Center integration within
    /// a
    /// domain.
    identity_center_options: ?IdentityCenterOptions,

    /// The type of IP addresses supported by the endpoint for the domain.
    ip_address_type: ?IPAddressType,

    /// Log publishing options for the domain.
    log_publishing_options: ?[]const aws.map.MapEntry(LogPublishingOption),

    /// Information about the domain properties that are currently being modified.
    modifying_properties: ?[]const ModifyingProperties,

    /// Whether node-to-node encryption is enabled or disabled.
    node_to_node_encryption_options: ?NodeToNodeEncryptionOptions,

    /// Options that specify a custom 10-hour window during which OpenSearch Service
    /// can perform
    /// configuration changes on the domain.
    off_peak_window_options: ?OffPeakWindowOptions,

    /// The status of the domain configuration. True if OpenSearch Service is
    /// processing
    /// configuration changes. False if the configuration is active.
    processing: ?bool,

    /// The current status of the domain's service software.
    service_software_options: ?ServiceSoftwareOptions,

    /// DEPRECATED. Container for parameters required to configure automated
    /// snapshots of
    /// domain indexes.
    snapshot_options: ?SnapshotOptions,

    /// Service software update options for the domain.
    software_update_options: ?SoftwareUpdateOptions,

    /// The status of a domain version upgrade to a new version of OpenSearch or
    /// Elasticsearch. True if OpenSearch Service is in the process of a version
    /// upgrade. False
    /// if the configuration is active.
    upgrade_processing: ?bool,

    /// The VPC configuration for the domain.
    vpc_options: ?VPCDerivedInfo,

    pub const json_field_names = .{
        .access_policies = "AccessPolicies",
        .advanced_options = "AdvancedOptions",
        .advanced_security_options = "AdvancedSecurityOptions",
        .aiml_options = "AIMLOptions",
        .arn = "ARN",
        .auto_tune_options = "AutoTuneOptions",
        .change_progress_details = "ChangeProgressDetails",
        .cluster_config = "ClusterConfig",
        .cognito_options = "CognitoOptions",
        .created = "Created",
        .deleted = "Deleted",
        .domain_endpoint_options = "DomainEndpointOptions",
        .domain_endpoint_v2_hosted_zone_id = "DomainEndpointV2HostedZoneId",
        .domain_id = "DomainId",
        .domain_name = "DomainName",
        .domain_processing_status = "DomainProcessingStatus",
        .ebs_options = "EBSOptions",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .endpoint = "Endpoint",
        .endpoints = "Endpoints",
        .endpoint_v2 = "EndpointV2",
        .engine_version = "EngineVersion",
        .identity_center_options = "IdentityCenterOptions",
        .ip_address_type = "IPAddressType",
        .log_publishing_options = "LogPublishingOptions",
        .modifying_properties = "ModifyingProperties",
        .node_to_node_encryption_options = "NodeToNodeEncryptionOptions",
        .off_peak_window_options = "OffPeakWindowOptions",
        .processing = "Processing",
        .service_software_options = "ServiceSoftwareOptions",
        .snapshot_options = "SnapshotOptions",
        .software_update_options = "SoftwareUpdateOptions",
        .upgrade_processing = "UpgradeProcessing",
        .vpc_options = "VPCOptions",
    };
};
