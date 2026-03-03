const AccessPoliciesStatus = @import("access_policies_status.zig").AccessPoliciesStatus;
const AdvancedOptionsStatus = @import("advanced_options_status.zig").AdvancedOptionsStatus;
const AdvancedSecurityOptionsStatus = @import("advanced_security_options_status.zig").AdvancedSecurityOptionsStatus;
const AIMLOptionsStatus = @import("aiml_options_status.zig").AIMLOptionsStatus;
const AutoTuneOptionsStatus = @import("auto_tune_options_status.zig").AutoTuneOptionsStatus;
const ChangeProgressDetails = @import("change_progress_details.zig").ChangeProgressDetails;
const ClusterConfigStatus = @import("cluster_config_status.zig").ClusterConfigStatus;
const CognitoOptionsStatus = @import("cognito_options_status.zig").CognitoOptionsStatus;
const DomainEndpointOptionsStatus = @import("domain_endpoint_options_status.zig").DomainEndpointOptionsStatus;
const EBSOptionsStatus = @import("ebs_options_status.zig").EBSOptionsStatus;
const EncryptionAtRestOptionsStatus = @import("encryption_at_rest_options_status.zig").EncryptionAtRestOptionsStatus;
const VersionStatus = @import("version_status.zig").VersionStatus;
const IdentityCenterOptionsStatus = @import("identity_center_options_status.zig").IdentityCenterOptionsStatus;
const IPAddressTypeStatus = @import("ip_address_type_status.zig").IPAddressTypeStatus;
const LogPublishingOptionsStatus = @import("log_publishing_options_status.zig").LogPublishingOptionsStatus;
const ModifyingProperties = @import("modifying_properties.zig").ModifyingProperties;
const NodeToNodeEncryptionOptionsStatus = @import("node_to_node_encryption_options_status.zig").NodeToNodeEncryptionOptionsStatus;
const OffPeakWindowOptionsStatus = @import("off_peak_window_options_status.zig").OffPeakWindowOptionsStatus;
const SnapshotOptionsStatus = @import("snapshot_options_status.zig").SnapshotOptionsStatus;
const SoftwareUpdateOptionsStatus = @import("software_update_options_status.zig").SoftwareUpdateOptionsStatus;
const VPCDerivedInfoStatus = @import("vpc_derived_info_status.zig").VPCDerivedInfoStatus;

/// Container for the configuration of an OpenSearch Service domain.
pub const DomainConfig = struct {
    /// Specifies the access policies for the domain.
    access_policies: ?AccessPoliciesStatus = null,

    /// Key-value pairs to specify advanced configuration options. For more
    /// information, see
    /// [Advanced
    /// options](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/createupdatedomains.html#createdomain-configure-advanced-options).
    advanced_options: ?AdvancedOptionsStatus = null,

    /// Container for fine-grained access control settings for the domain.
    advanced_security_options: ?AdvancedSecurityOptionsStatus = null,

    /// Container for parameters required to enable all machine learning features.
    aiml_options: ?AIMLOptionsStatus = null,

    /// Container for Auto-Tune settings for the domain.
    auto_tune_options: ?AutoTuneOptionsStatus = null,

    /// Container for information about the progress of an existing configuration
    /// change.
    change_progress_details: ?ChangeProgressDetails = null,

    /// Container for the cluster configuration of a the domain.
    cluster_config: ?ClusterConfigStatus = null,

    /// Container for Amazon Cognito options for the domain.
    cognito_options: ?CognitoOptionsStatus = null,

    /// Additional options for the domain endpoint, such as whether to require HTTPS
    /// for all
    /// traffic.
    domain_endpoint_options: ?DomainEndpointOptionsStatus = null,

    /// Container for EBS options configured for the domain.
    ebs_options: ?EBSOptionsStatus = null,

    /// Key-value pairs to enable encryption at rest.
    encryption_at_rest_options: ?EncryptionAtRestOptionsStatus = null,

    /// The OpenSearch or Elasticsearch version that the domain is running.
    engine_version: ?VersionStatus = null,

    /// Configuration options for enabling and managing IAM Identity Center
    /// integration within
    /// a domain.
    identity_center_options: ?IdentityCenterOptionsStatus = null,

    /// Choose either dual stack or IPv4 as your IP address type. Dual stack allows
    /// you to
    /// share domain resources across IPv4 and IPv6 address types, and is the
    /// recommended
    /// option. If you set your IP address type to dual stack, you can't change your
    /// address
    /// type later.
    ip_address_type: ?IPAddressTypeStatus = null,

    /// Key-value pairs to configure log publishing.
    log_publishing_options: ?LogPublishingOptionsStatus = null,

    /// Information about the domain properties that are currently being modified.
    modifying_properties: ?[]const ModifyingProperties = null,

    /// Whether node-to-node encryption is enabled or disabled.
    node_to_node_encryption_options: ?NodeToNodeEncryptionOptionsStatus = null,

    /// Container for off-peak window options for the domain.
    off_peak_window_options: ?OffPeakWindowOptionsStatus = null,

    /// DEPRECATED. Container for parameters required to configure automated
    /// snapshots of
    /// domain indexes.
    snapshot_options: ?SnapshotOptionsStatus = null,

    /// Software update options for the domain.
    software_update_options: ?SoftwareUpdateOptionsStatus = null,

    /// The current VPC options for the domain and the status of any updates to
    /// their
    /// configuration.
    vpc_options: ?VPCDerivedInfoStatus = null,

    pub const json_field_names = .{
        .access_policies = "AccessPolicies",
        .advanced_options = "AdvancedOptions",
        .advanced_security_options = "AdvancedSecurityOptions",
        .aiml_options = "AIMLOptions",
        .auto_tune_options = "AutoTuneOptions",
        .change_progress_details = "ChangeProgressDetails",
        .cluster_config = "ClusterConfig",
        .cognito_options = "CognitoOptions",
        .domain_endpoint_options = "DomainEndpointOptions",
        .ebs_options = "EBSOptions",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .engine_version = "EngineVersion",
        .identity_center_options = "IdentityCenterOptions",
        .ip_address_type = "IPAddressType",
        .log_publishing_options = "LogPublishingOptions",
        .modifying_properties = "ModifyingProperties",
        .node_to_node_encryption_options = "NodeToNodeEncryptionOptions",
        .off_peak_window_options = "OffPeakWindowOptions",
        .snapshot_options = "SnapshotOptions",
        .software_update_options = "SoftwareUpdateOptions",
        .vpc_options = "VPCOptions",
    };
};
