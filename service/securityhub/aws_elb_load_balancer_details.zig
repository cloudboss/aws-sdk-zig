const AwsElbLoadBalancerBackendServerDescription = @import("aws_elb_load_balancer_backend_server_description.zig").AwsElbLoadBalancerBackendServerDescription;
const AwsElbLoadBalancerHealthCheck = @import("aws_elb_load_balancer_health_check.zig").AwsElbLoadBalancerHealthCheck;
const AwsElbLoadBalancerInstance = @import("aws_elb_load_balancer_instance.zig").AwsElbLoadBalancerInstance;
const AwsElbLoadBalancerListenerDescription = @import("aws_elb_load_balancer_listener_description.zig").AwsElbLoadBalancerListenerDescription;
const AwsElbLoadBalancerAttributes = @import("aws_elb_load_balancer_attributes.zig").AwsElbLoadBalancerAttributes;
const AwsElbLoadBalancerPolicies = @import("aws_elb_load_balancer_policies.zig").AwsElbLoadBalancerPolicies;
const AwsElbLoadBalancerSourceSecurityGroup = @import("aws_elb_load_balancer_source_security_group.zig").AwsElbLoadBalancerSourceSecurityGroup;

/// Contains details about a Classic Load Balancer.
pub const AwsElbLoadBalancerDetails = struct {
    /// The list of Availability Zones for the load balancer.
    availability_zones: ?[]const []const u8 = null,

    /// Information about the configuration of the EC2 instances.
    backend_server_descriptions: ?[]const AwsElbLoadBalancerBackendServerDescription = null,

    /// The name of the Amazon Route 53 hosted zone for the load balancer.
    canonical_hosted_zone_name: ?[]const u8 = null,

    /// The ID of the Amazon Route 53 hosted zone for the load balancer.
    canonical_hosted_zone_name_id: ?[]const u8 = null,

    /// Indicates when the load balancer was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_time: ?[]const u8 = null,

    /// The DNS name of the load balancer.
    dns_name: ?[]const u8 = null,

    /// Information about the health checks that are conducted on the load balancer.
    health_check: ?AwsElbLoadBalancerHealthCheck = null,

    /// List of EC2 instances for the load balancer.
    instances: ?[]const AwsElbLoadBalancerInstance = null,

    /// The policies that are enabled for the load balancer listeners.
    listener_descriptions: ?[]const AwsElbLoadBalancerListenerDescription = null,

    /// The attributes for a load balancer.
    load_balancer_attributes: ?AwsElbLoadBalancerAttributes = null,

    /// The name of the load balancer.
    load_balancer_name: ?[]const u8 = null,

    /// The policies for a load balancer.
    policies: ?AwsElbLoadBalancerPolicies = null,

    /// The type of load balancer. Only provided if the load balancer is in a VPC.
    ///
    /// If `Scheme` is `internet-facing`, the load balancer has a public
    /// DNS name that resolves to a public IP address.
    ///
    /// If `Scheme` is `internal`, the load balancer has a public DNS name
    /// that resolves to a private IP address.
    scheme: ?[]const u8 = null,

    /// The security groups for the load balancer. Only provided if the load
    /// balancer is in a
    /// VPC.
    security_groups: ?[]const []const u8 = null,

    /// Information about the security group for the load balancer. This is the
    /// security group
    /// that is used for inbound rules.
    source_security_group: ?AwsElbLoadBalancerSourceSecurityGroup = null,

    /// The list of subnet identifiers for the load balancer.
    subnets: ?[]const []const u8 = null,

    /// The identifier of the VPC for the load balancer.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .backend_server_descriptions = "BackendServerDescriptions",
        .canonical_hosted_zone_name = "CanonicalHostedZoneName",
        .canonical_hosted_zone_name_id = "CanonicalHostedZoneNameID",
        .created_time = "CreatedTime",
        .dns_name = "DnsName",
        .health_check = "HealthCheck",
        .instances = "Instances",
        .listener_descriptions = "ListenerDescriptions",
        .load_balancer_attributes = "LoadBalancerAttributes",
        .load_balancer_name = "LoadBalancerName",
        .policies = "Policies",
        .scheme = "Scheme",
        .security_groups = "SecurityGroups",
        .source_security_group = "SourceSecurityGroup",
        .subnets = "Subnets",
        .vpc_id = "VpcId",
    };
};
