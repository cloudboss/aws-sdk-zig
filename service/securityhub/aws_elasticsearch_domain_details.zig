const aws = @import("aws");

const AwsElasticsearchDomainDomainEndpointOptions = @import("aws_elasticsearch_domain_domain_endpoint_options.zig").AwsElasticsearchDomainDomainEndpointOptions;
const AwsElasticsearchDomainElasticsearchClusterConfigDetails = @import("aws_elasticsearch_domain_elasticsearch_cluster_config_details.zig").AwsElasticsearchDomainElasticsearchClusterConfigDetails;
const AwsElasticsearchDomainEncryptionAtRestOptions = @import("aws_elasticsearch_domain_encryption_at_rest_options.zig").AwsElasticsearchDomainEncryptionAtRestOptions;
const AwsElasticsearchDomainLogPublishingOptions = @import("aws_elasticsearch_domain_log_publishing_options.zig").AwsElasticsearchDomainLogPublishingOptions;
const AwsElasticsearchDomainNodeToNodeEncryptionOptions = @import("aws_elasticsearch_domain_node_to_node_encryption_options.zig").AwsElasticsearchDomainNodeToNodeEncryptionOptions;
const AwsElasticsearchDomainServiceSoftwareOptions = @import("aws_elasticsearch_domain_service_software_options.zig").AwsElasticsearchDomainServiceSoftwareOptions;
const AwsElasticsearchDomainVPCOptions = @import("aws_elasticsearch_domain_vpc_options.zig").AwsElasticsearchDomainVPCOptions;

/// Information about an Elasticsearch domain.
pub const AwsElasticsearchDomainDetails = struct {
    /// IAM policy document specifying the access policies for the new Elasticsearch
    /// domain.
    access_policies: ?[]const u8,

    /// Additional options for the domain endpoint.
    domain_endpoint_options: ?AwsElasticsearchDomainDomainEndpointOptions,

    /// Unique identifier for an Elasticsearch domain.
    domain_id: ?[]const u8,

    /// Name of an Elasticsearch domain.
    ///
    /// Domain names are unique across all domains owned by the same account within
    /// an Amazon Web Services
    /// Region.
    ///
    /// Domain names must start with a lowercase letter and must be between 3 and 28
    /// characters.
    ///
    /// Valid characters are a-z (lowercase only), 0-9, and – (hyphen).
    domain_name: ?[]const u8,

    /// Information about an OpenSearch cluster configuration.
    elasticsearch_cluster_config: ?AwsElasticsearchDomainElasticsearchClusterConfigDetails,

    /// OpenSearch version.
    elasticsearch_version: ?[]const u8,

    /// Details about the configuration for encryption at rest.
    encryption_at_rest_options: ?AwsElasticsearchDomainEncryptionAtRestOptions,

    /// Domain-specific endpoint used to submit index, search, and data upload
    /// requests to an
    /// Elasticsearch domain.
    ///
    /// The endpoint is a service URL.
    endpoint: ?[]const u8,

    /// The key-value pair that exists if the Elasticsearch domain uses VPC
    /// endpoints.
    endpoints: ?[]const aws.map.StringMapEntry,

    /// Configures the CloudWatch Logs to publish for the Elasticsearch domain.
    log_publishing_options: ?AwsElasticsearchDomainLogPublishingOptions,

    /// Details about the configuration for node-to-node encryption.
    node_to_node_encryption_options: ?AwsElasticsearchDomainNodeToNodeEncryptionOptions,

    /// Information about the status of a domain relative to the latest service
    /// software.
    service_software_options: ?AwsElasticsearchDomainServiceSoftwareOptions,

    /// Information that OpenSearch derives based on `VPCOptions` for the
    /// domain.
    vpc_options: ?AwsElasticsearchDomainVPCOptions,

    pub const json_field_names = .{
        .access_policies = "AccessPolicies",
        .domain_endpoint_options = "DomainEndpointOptions",
        .domain_id = "DomainId",
        .domain_name = "DomainName",
        .elasticsearch_cluster_config = "ElasticsearchClusterConfig",
        .elasticsearch_version = "ElasticsearchVersion",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .endpoint = "Endpoint",
        .endpoints = "Endpoints",
        .log_publishing_options = "LogPublishingOptions",
        .node_to_node_encryption_options = "NodeToNodeEncryptionOptions",
        .service_software_options = "ServiceSoftwareOptions",
        .vpc_options = "VPCOptions",
    };
};
