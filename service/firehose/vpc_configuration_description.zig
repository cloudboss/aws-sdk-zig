/// The details of the VPC of the Amazon OpenSearch Service destination.
pub const VpcConfigurationDescription = struct {
    /// The ARN of the IAM role that the Firehose stream uses to create endpoints in
    /// the
    /// destination VPC. You can use your existing Firehose delivery role or you can
    /// specify a new role. In either case, make sure that the role trusts the
    /// Firehose service principal and that it grants the following permissions:
    ///
    /// * `ec2:DescribeVpcs`
    ///
    /// * `ec2:DescribeVpcAttribute`
    ///
    /// * `ec2:DescribeSubnets`
    ///
    /// * `ec2:DescribeSecurityGroups`
    ///
    /// * `ec2:DescribeNetworkInterfaces`
    ///
    /// * `ec2:CreateNetworkInterface`
    ///
    /// * `ec2:CreateNetworkInterfacePermission`
    ///
    /// * `ec2:DeleteNetworkInterface`
    ///
    /// If you revoke these permissions after you create the Firehose stream,
    /// Firehose can't scale out by creating more ENIs when necessary. You might
    /// therefore see a
    /// degradation in performance.
    role_arn: []const u8,

    /// The IDs of the security groups that Firehose uses when it creates ENIs in
    /// the VPC of the Amazon OpenSearch Service destination. You can use the same
    /// security group that the Amazon
    /// ES domain uses or different ones. If you specify different security groups,
    /// ensure that
    /// they allow outbound HTTPS traffic to the Amazon OpenSearch Service domain's
    /// security group. Also ensure
    /// that the Amazon OpenSearch Service domain's security group allows HTTPS
    /// traffic from the security groups
    /// specified here. If you use the same security group for both your Firehose
    /// stream and the
    /// Amazon OpenSearch Service domain, make sure the security group inbound rule
    /// allows HTTPS traffic. For more
    /// information about security group rules, see [Security group
    /// rules](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html#SecurityGroupRules) in the Amazon VPC documentation.
    security_group_ids: []const []const u8,

    /// The IDs of the subnets that Firehose uses to create ENIs in the VPC of the
    /// Amazon OpenSearch Service destination. Make sure that the routing tables and
    /// inbound and outbound rules
    /// allow traffic to flow from the subnets whose IDs are specified here to the
    /// subnets that
    /// have the destination Amazon OpenSearch Service endpoints. Firehose creates
    /// at least one ENI in
    /// each of the subnets that are specified here. Do not delete or modify these
    /// ENIs.
    ///
    /// The number of ENIs that Firehose creates in the subnets specified here
    /// scales up and down automatically based on throughput. To enable Firehose to
    /// scale up the number of ENIs to match throughput, ensure that you have
    /// sufficient quota. To
    /// help you calculate the quota you need, assume that Firehose can create up to
    /// three ENIs for this Firehose stream for each of the subnets specified here.
    /// For more
    /// information about ENI quota, see [Network Interfaces
    /// ](https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html#vpc-limits-enis) in the Amazon VPC Quotas topic.
    subnet_ids: []const []const u8,

    /// The ID of the Amazon OpenSearch Service destination's VPC.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .role_arn = "RoleARN",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .vpc_id = "VpcId",
    };
};
