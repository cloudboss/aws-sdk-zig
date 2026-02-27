const aws = @import("aws");

const Resource = @import("resource.zig").Resource;

/// A collection of resources of the same type.
pub const ResourceSetOutput = struct {
    /// A list of resource objects.
    resources: []const Resource,

    /// The Amazon Resource Name (ARN) for the resource set.
    resource_set_arn: []const u8,

    /// The name of the resource set.
    resource_set_name: []const u8,

    /// The resource type of the resources in the resource set. Enter one of the
    /// following values for resource type:
    ///
    /// AWS::ApiGateway::Stage, AWS::ApiGatewayV2::Stage,
    /// AWS::AutoScaling::AutoScalingGroup, AWS::CloudWatch::Alarm,
    /// AWS::EC2::CustomerGateway, AWS::DynamoDB::Table, AWS::EC2::Volume,
    /// AWS::ElasticLoadBalancing::LoadBalancer,
    /// AWS::ElasticLoadBalancingV2::LoadBalancer, AWS::Lambda::Function,
    /// AWS::MSK::Cluster, AWS::RDS::DBCluster, AWS::Route53::HealthCheck,
    /// AWS::SQS::Queue, AWS::SNS::Topic, AWS::SNS::Subscription, AWS::EC2::VPC,
    /// AWS::EC2::VPNConnection, AWS::EC2::VPNGateway,
    /// AWS::Route53RecoveryReadiness::DNSTargetResource
    resource_set_type: []const u8,

    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resources = "Resources",
        .resource_set_arn = "ResourceSetArn",
        .resource_set_name = "ResourceSetName",
        .resource_set_type = "ResourceSetType",
        .tags = "Tags",
    };
};
