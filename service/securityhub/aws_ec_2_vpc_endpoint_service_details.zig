const AwsEc2VpcEndpointServiceServiceTypeDetails = @import("aws_ec_2_vpc_endpoint_service_service_type_details.zig").AwsEc2VpcEndpointServiceServiceTypeDetails;

/// Contains details about the service configuration for a VPC endpoint service.
pub const AwsEc2VpcEndpointServiceDetails = struct {
    /// Whether requests from other Amazon Web Services accounts to create an
    /// endpoint to the service must first be accepted.
    acceptance_required: ?bool = null,

    /// The Availability Zones where the service is available.
    availability_zones: ?[]const []const u8 = null,

    /// The DNS names for the service.
    base_endpoint_dns_names: ?[]const []const u8 = null,

    /// The ARNs of the Gateway Load Balancers for the service.
    gateway_load_balancer_arns: ?[]const []const u8 = null,

    /// Whether the service manages its VPC endpoints.
    manages_vpc_endpoints: ?bool = null,

    /// The ARNs of the Network Load Balancers for the service.
    network_load_balancer_arns: ?[]const []const u8 = null,

    /// The private DNS name for the service.
    private_dns_name: ?[]const u8 = null,

    /// The identifier of the service.
    service_id: ?[]const u8 = null,

    /// The name of the service.
    service_name: ?[]const u8 = null,

    /// The current state of the service. Valid values are as follows:
    ///
    /// * `Available`
    ///
    /// * `Deleted`
    ///
    /// * `Deleting`
    ///
    /// * `Failed`
    ///
    /// * `Pending`
    service_state: ?[]const u8 = null,

    /// The types for the service.
    service_type: ?[]const AwsEc2VpcEndpointServiceServiceTypeDetails = null,

    pub const json_field_names = .{
        .acceptance_required = "AcceptanceRequired",
        .availability_zones = "AvailabilityZones",
        .base_endpoint_dns_names = "BaseEndpointDnsNames",
        .gateway_load_balancer_arns = "GatewayLoadBalancerArns",
        .manages_vpc_endpoints = "ManagesVpcEndpoints",
        .network_load_balancer_arns = "NetworkLoadBalancerArns",
        .private_dns_name = "PrivateDnsName",
        .service_id = "ServiceId",
        .service_name = "ServiceName",
        .service_state = "ServiceState",
        .service_type = "ServiceType",
    };
};
