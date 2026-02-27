/// Describes the configuration of an Amazon Elastic Kubernetes Service
/// endpoint.
pub const EksEndpointsConfiguration = struct {
    /// The CA certificate chain of the cluster API server.
    cluster_api_server_ca_certificate_chain: []const u8,

    /// The URI of the cluster API server endpoint.
    cluster_api_server_endpoint_uri: []const u8,

    /// The name of the cluster.
    cluster_name: []const u8,

    /// The name of the endpoint resource.
    endpoints_resource_name: []const u8,

    /// The namespace of the endpoint resource.
    endpoints_resource_namespace: []const u8,

    /// The role ARN for the cluster.
    role_arn: []const u8,

    pub const json_field_names = .{
        .cluster_api_server_ca_certificate_chain = "clusterApiServerCaCertificateChain",
        .cluster_api_server_endpoint_uri = "clusterApiServerEndpointUri",
        .cluster_name = "clusterName",
        .endpoints_resource_name = "endpointsResourceName",
        .endpoints_resource_namespace = "endpointsResourceNamespace",
        .role_arn = "roleArn",
    };
};
