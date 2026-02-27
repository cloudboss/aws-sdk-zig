/// Details of an Amazon VPC which has network connectivity to the Apache Kafka
/// cluster.
pub const KafkaClusterClientVpcConfig = struct {
    /// The security groups to attach to the ENIs for the broker nodes.
    security_group_ids: ?[]const []const u8,

    /// The list of subnets in the client VPC to connect to.
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
