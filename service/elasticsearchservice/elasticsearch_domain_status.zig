const aws = @import("aws");

const AdvancedSecurityOptions = @import("advanced_security_options.zig").AdvancedSecurityOptions;
const AutoTuneOptionsOutput = @import("auto_tune_options_output.zig").AutoTuneOptionsOutput;
const ChangeProgressDetails = @import("change_progress_details.zig").ChangeProgressDetails;
const CognitoOptions = @import("cognito_options.zig").CognitoOptions;
const DeploymentStrategyOptions = @import("deployment_strategy_options.zig").DeploymentStrategyOptions;
const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const DomainProcessingStatusType = @import("domain_processing_status_type.zig").DomainProcessingStatusType;
const EBSOptions = @import("ebs_options.zig").EBSOptions;
const ElasticsearchClusterConfig = @import("elasticsearch_cluster_config.zig").ElasticsearchClusterConfig;
const EncryptionAtRestOptions = @import("encryption_at_rest_options.zig").EncryptionAtRestOptions;
const LogPublishingOption = @import("log_publishing_option.zig").LogPublishingOption;
const ModifyingProperties = @import("modifying_properties.zig").ModifyingProperties;
const NodeToNodeEncryptionOptions = @import("node_to_node_encryption_options.zig").NodeToNodeEncryptionOptions;
const ServiceSoftwareOptions = @import("service_software_options.zig").ServiceSoftwareOptions;
const SnapshotOptions = @import("snapshot_options.zig").SnapshotOptions;
const VPCDerivedInfo = @import("vpc_derived_info.zig").VPCDerivedInfo;

/// The current status of an Elasticsearch domain.
pub const ElasticsearchDomainStatus = struct {
    /// IAM access policy as a JSON-formatted string.
    access_policies: ?[]const u8 = null,

    /// Specifies the status of the `AdvancedOptions`
    advanced_options: ?[]const aws.map.StringMapEntry = null,

    /// The current status of the Elasticsearch domain's advanced security options.
    advanced_security_options: ?AdvancedSecurityOptions = null,

    /// The Amazon resource name (ARN) of an Elasticsearch domain. See [Identifiers
    /// for IAM
    /// Entities](http://docs.aws.amazon.com/IAM/latest/UserGuide/index.html?Using_Identifiers.html) in *Using AWS Identity and Access Management* for more information.
    arn: []const u8,

    /// The current status of the Elasticsearch domain's Auto-Tune options.
    auto_tune_options: ?AutoTuneOptionsOutput = null,

    /// Specifies change details of the domain configuration change.
    change_progress_details: ?ChangeProgressDetails = null,

    /// The `CognitoOptions` for the specified domain. For more information, see
    /// [Amazon Cognito Authentication for
    /// Kibana](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-cognito-auth.html).
    cognito_options: ?CognitoOptions = null,

    /// The domain creation status. `True` if the creation of an Elasticsearch
    /// domain is complete. `False` if domain creation is still in progress.
    created: ?bool = null,

    /// The domain deletion status. `True` if a delete request has been received for
    /// the domain but resource cleanup is still in progress. `False` if the domain
    /// has not been deleted. Once domain deletion is complete, the status of the
    /// domain is no longer returned.
    deleted: ?bool = null,

    /// The current status of the Elasticsearch domain's deployment strategy
    /// options.
    deployment_strategy_options: ?DeploymentStrategyOptions = null,

    /// The current status of the Elasticsearch domain's endpoint options.
    domain_endpoint_options: ?DomainEndpointOptions = null,

    /// The unique identifier for the specified Elasticsearch domain.
    domain_id: []const u8,

    /// The name of an Elasticsearch domain. Domain names are unique across the
    /// domains owned by an account within an AWS region. Domain names start with a
    /// letter or number and can contain the following characters: a-z (lowercase),
    /// 0-9, and - (hyphen).
    domain_name: []const u8,

    /// The status of any changes that are currently in progress for the domain.
    domain_processing_status: ?DomainProcessingStatusType = null,

    /// The `EBSOptions` for the specified domain. See [Configuring EBS-based
    /// Storage](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomain-configure-ebs) for more information.
    ebs_options: ?EBSOptions = null,

    /// The type and number of instances in the domain cluster.
    elasticsearch_cluster_config: ElasticsearchClusterConfig,

    elasticsearch_version: ?[]const u8 = null,

    /// Specifies the status of the `EncryptionAtRestOptions`.
    encryption_at_rest_options: ?EncryptionAtRestOptions = null,

    /// The Elasticsearch domain endpoint that you use to submit index and search
    /// requests.
    endpoint: ?[]const u8 = null,

    /// Map containing the Elasticsearch domain endpoints used to submit index and
    /// search requests. Example `key, value`:
    /// `'vpc','vpc-endpoint-h2dsd34efgyghrtguk5gt6j2foh4.us-east-1.es.amazonaws.com'`.
    endpoints: ?[]const aws.map.StringMapEntry = null,

    /// Log publishing options for the given domain.
    log_publishing_options: ?[]const aws.map.MapEntry(LogPublishingOption) = null,

    /// Information about the domain properties that are currently being modified.
    modifying_properties: ?[]const ModifyingProperties = null,

    /// Specifies the status of the `NodeToNodeEncryptionOptions`.
    node_to_node_encryption_options: ?NodeToNodeEncryptionOptions = null,

    /// The status of the Elasticsearch domain configuration. `True` if Amazon
    /// Elasticsearch Service is processing configuration changes. `False` if the
    /// configuration is active.
    processing: ?bool = null,

    /// The current status of the Elasticsearch domain's service software.
    service_software_options: ?ServiceSoftwareOptions = null,

    /// Specifies the status of the `SnapshotOptions`
    snapshot_options: ?SnapshotOptions = null,

    /// The status of an Elasticsearch domain version upgrade. `True` if Amazon
    /// Elasticsearch Service is undergoing a version upgrade. `False` if the
    /// configuration is active.
    upgrade_processing: ?bool = null,

    /// The `VPCOptions` for the specified domain. For more information, see [VPC
    /// Endpoints for Amazon Elasticsearch Service
    /// Domains](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-vpc.html).
    vpc_options: ?VPCDerivedInfo = null,

    pub const json_field_names = .{
        .access_policies = "AccessPolicies",
        .advanced_options = "AdvancedOptions",
        .advanced_security_options = "AdvancedSecurityOptions",
        .arn = "ARN",
        .auto_tune_options = "AutoTuneOptions",
        .change_progress_details = "ChangeProgressDetails",
        .cognito_options = "CognitoOptions",
        .created = "Created",
        .deleted = "Deleted",
        .deployment_strategy_options = "DeploymentStrategyOptions",
        .domain_endpoint_options = "DomainEndpointOptions",
        .domain_id = "DomainId",
        .domain_name = "DomainName",
        .domain_processing_status = "DomainProcessingStatus",
        .ebs_options = "EBSOptions",
        .elasticsearch_cluster_config = "ElasticsearchClusterConfig",
        .elasticsearch_version = "ElasticsearchVersion",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .endpoint = "Endpoint",
        .endpoints = "Endpoints",
        .log_publishing_options = "LogPublishingOptions",
        .modifying_properties = "ModifyingProperties",
        .node_to_node_encryption_options = "NodeToNodeEncryptionOptions",
        .processing = "Processing",
        .service_software_options = "ServiceSoftwareOptions",
        .snapshot_options = "SnapshotOptions",
        .upgrade_processing = "UpgradeProcessing",
        .vpc_options = "VPCOptions",
    };
};
