const aws = @import("aws");

const AwsOpenSearchServiceDomainAdvancedSecurityOptionsDetails = @import("aws_open_search_service_domain_advanced_security_options_details.zig").AwsOpenSearchServiceDomainAdvancedSecurityOptionsDetails;
const AwsOpenSearchServiceDomainClusterConfigDetails = @import("aws_open_search_service_domain_cluster_config_details.zig").AwsOpenSearchServiceDomainClusterConfigDetails;
const AwsOpenSearchServiceDomainDomainEndpointOptionsDetails = @import("aws_open_search_service_domain_domain_endpoint_options_details.zig").AwsOpenSearchServiceDomainDomainEndpointOptionsDetails;
const AwsOpenSearchServiceDomainEncryptionAtRestOptionsDetails = @import("aws_open_search_service_domain_encryption_at_rest_options_details.zig").AwsOpenSearchServiceDomainEncryptionAtRestOptionsDetails;
const AwsOpenSearchServiceDomainLogPublishingOptionsDetails = @import("aws_open_search_service_domain_log_publishing_options_details.zig").AwsOpenSearchServiceDomainLogPublishingOptionsDetails;
const AwsOpenSearchServiceDomainNodeToNodeEncryptionOptionsDetails = @import("aws_open_search_service_domain_node_to_node_encryption_options_details.zig").AwsOpenSearchServiceDomainNodeToNodeEncryptionOptionsDetails;
const AwsOpenSearchServiceDomainServiceSoftwareOptionsDetails = @import("aws_open_search_service_domain_service_software_options_details.zig").AwsOpenSearchServiceDomainServiceSoftwareOptionsDetails;
const AwsOpenSearchServiceDomainVpcOptionsDetails = @import("aws_open_search_service_domain_vpc_options_details.zig").AwsOpenSearchServiceDomainVpcOptionsDetails;

/// Information about an Amazon OpenSearch Service domain.
pub const AwsOpenSearchServiceDomainDetails = struct {
    /// IAM policy document that specifies the access policies for the OpenSearch
    /// Service domain.
    access_policies: ?[]const u8,

    /// Specifies options for fine-grained access control.
    advanced_security_options: ?AwsOpenSearchServiceDomainAdvancedSecurityOptionsDetails,

    /// The ARN of the OpenSearch Service domain.
    arn: ?[]const u8,

    /// Details about the configuration of an OpenSearch cluster.
    cluster_config: ?AwsOpenSearchServiceDomainClusterConfigDetails,

    /// The domain endpoint.
    domain_endpoint: ?[]const u8,

    /// Additional options for the domain endpoint.
    domain_endpoint_options: ?AwsOpenSearchServiceDomainDomainEndpointOptionsDetails,

    /// The domain endpoints. Used if the OpenSearch domain resides in a VPC.
    ///
    /// This is a map of key-value pairs. The key is always `vpc`. The value is the
    /// endpoint.
    domain_endpoints: ?[]const aws.map.StringMapEntry,

    /// The name of the endpoint.
    domain_name: ?[]const u8,

    /// Details about the configuration for encryption at rest.
    encryption_at_rest_options: ?AwsOpenSearchServiceDomainEncryptionAtRestOptionsDetails,

    /// The version of the domain engine.
    engine_version: ?[]const u8,

    /// The identifier of the domain.
    id: ?[]const u8,

    /// Configures the CloudWatch Logs to publish for the OpenSearch domain.
    log_publishing_options: ?AwsOpenSearchServiceDomainLogPublishingOptionsDetails,

    /// Details about the configuration for node-to-node encryption.
    node_to_node_encryption_options: ?AwsOpenSearchServiceDomainNodeToNodeEncryptionOptionsDetails,

    /// Information about the status of a domain relative to the latest service
    /// software.
    service_software_options: ?AwsOpenSearchServiceDomainServiceSoftwareOptionsDetails,

    /// Information that OpenSearch Service derives based on `VPCOptions` for the
    /// domain.
    vpc_options: ?AwsOpenSearchServiceDomainVpcOptionsDetails,

    pub const json_field_names = .{
        .access_policies = "AccessPolicies",
        .advanced_security_options = "AdvancedSecurityOptions",
        .arn = "Arn",
        .cluster_config = "ClusterConfig",
        .domain_endpoint = "DomainEndpoint",
        .domain_endpoint_options = "DomainEndpointOptions",
        .domain_endpoints = "DomainEndpoints",
        .domain_name = "DomainName",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .engine_version = "EngineVersion",
        .id = "Id",
        .log_publishing_options = "LogPublishingOptions",
        .node_to_node_encryption_options = "NodeToNodeEncryptionOptions",
        .service_software_options = "ServiceSoftwareOptions",
        .vpc_options = "VpcOptions",
    };
};
