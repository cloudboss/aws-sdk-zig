const AccessPoliciesStatus = @import("access_policies_status.zig").AccessPoliciesStatus;
const AdvancedOptionsStatus = @import("advanced_options_status.zig").AdvancedOptionsStatus;
const AdvancedSecurityOptionsStatus = @import("advanced_security_options_status.zig").AdvancedSecurityOptionsStatus;
const AutoTuneOptionsStatus = @import("auto_tune_options_status.zig").AutoTuneOptionsStatus;
const ChangeProgressDetails = @import("change_progress_details.zig").ChangeProgressDetails;
const CognitoOptionsStatus = @import("cognito_options_status.zig").CognitoOptionsStatus;
const DeploymentStrategyOptionsStatus = @import("deployment_strategy_options_status.zig").DeploymentStrategyOptionsStatus;
const DomainEndpointOptionsStatus = @import("domain_endpoint_options_status.zig").DomainEndpointOptionsStatus;
const EBSOptionsStatus = @import("ebs_options_status.zig").EBSOptionsStatus;
const ElasticsearchClusterConfigStatus = @import("elasticsearch_cluster_config_status.zig").ElasticsearchClusterConfigStatus;
const ElasticsearchVersionStatus = @import("elasticsearch_version_status.zig").ElasticsearchVersionStatus;
const EncryptionAtRestOptionsStatus = @import("encryption_at_rest_options_status.zig").EncryptionAtRestOptionsStatus;
const LogPublishingOptionsStatus = @import("log_publishing_options_status.zig").LogPublishingOptionsStatus;
const ModifyingProperties = @import("modifying_properties.zig").ModifyingProperties;
const NodeToNodeEncryptionOptionsStatus = @import("node_to_node_encryption_options_status.zig").NodeToNodeEncryptionOptionsStatus;
const SnapshotOptionsStatus = @import("snapshot_options_status.zig").SnapshotOptionsStatus;
const VPCDerivedInfoStatus = @import("vpc_derived_info_status.zig").VPCDerivedInfoStatus;

/// The configuration of an Elasticsearch domain.
pub const ElasticsearchDomainConfig = struct {
    /// IAM access policy as a JSON-formatted string.
    access_policies: ?AccessPoliciesStatus = null,

    /// Specifies the `AdvancedOptions` for the domain. See [Configuring Advanced
    /// Options](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomain-configure-advanced-options) for more information.
    advanced_options: ?AdvancedOptionsStatus = null,

    /// Specifies `AdvancedSecurityOptions` for the domain.
    advanced_security_options: ?AdvancedSecurityOptionsStatus = null,

    /// Specifies `AutoTuneOptions` for the domain.
    auto_tune_options: ?AutoTuneOptionsStatus = null,

    /// Specifies change details of the domain configuration change.
    change_progress_details: ?ChangeProgressDetails = null,

    /// The `CognitoOptions` for the specified domain. For more information, see
    /// [Amazon Cognito Authentication for
    /// Kibana](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-cognito-auth.html).
    cognito_options: ?CognitoOptionsStatus = null,

    /// Specifies `DeploymentStrategyOptions` for the domain.
    deployment_strategy_options: ?DeploymentStrategyOptionsStatus = null,

    /// Specifies the `DomainEndpointOptions` for the Elasticsearch domain.
    domain_endpoint_options: ?DomainEndpointOptionsStatus = null,

    /// Specifies the `EBSOptions` for the Elasticsearch domain.
    ebs_options: ?EBSOptionsStatus = null,

    /// Specifies the `ElasticsearchClusterConfig` for the Elasticsearch domain.
    elasticsearch_cluster_config: ?ElasticsearchClusterConfigStatus = null,

    /// String of format X.Y to specify version for the Elasticsearch domain.
    elasticsearch_version: ?ElasticsearchVersionStatus = null,

    /// Specifies the `EncryptionAtRestOptions` for the Elasticsearch domain.
    encryption_at_rest_options: ?EncryptionAtRestOptionsStatus = null,

    /// Log publishing options for the given domain.
    log_publishing_options: ?LogPublishingOptionsStatus = null,

    /// Information about the domain properties that are currently being modified.
    modifying_properties: ?[]const ModifyingProperties = null,

    /// Specifies the `NodeToNodeEncryptionOptions` for the Elasticsearch domain.
    node_to_node_encryption_options: ?NodeToNodeEncryptionOptionsStatus = null,

    /// Specifies the `SnapshotOptions` for the Elasticsearch domain.
    snapshot_options: ?SnapshotOptionsStatus = null,

    /// The `VPCOptions` for the specified domain. For more information, see [VPC
    /// Endpoints for Amazon Elasticsearch Service
    /// Domains](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-vpc.html).
    vpc_options: ?VPCDerivedInfoStatus = null,

    pub const json_field_names = .{
        .access_policies = "AccessPolicies",
        .advanced_options = "AdvancedOptions",
        .advanced_security_options = "AdvancedSecurityOptions",
        .auto_tune_options = "AutoTuneOptions",
        .change_progress_details = "ChangeProgressDetails",
        .cognito_options = "CognitoOptions",
        .deployment_strategy_options = "DeploymentStrategyOptions",
        .domain_endpoint_options = "DomainEndpointOptions",
        .ebs_options = "EBSOptions",
        .elasticsearch_cluster_config = "ElasticsearchClusterConfig",
        .elasticsearch_version = "ElasticsearchVersion",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .log_publishing_options = "LogPublishingOptions",
        .modifying_properties = "ModifyingProperties",
        .node_to_node_encryption_options = "NodeToNodeEncryptionOptions",
        .snapshot_options = "SnapshotOptions",
        .vpc_options = "VPCOptions",
    };
};
