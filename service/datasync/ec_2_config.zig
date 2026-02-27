/// The subnet and security groups that DataSync uses to connect to one of your
/// Amazon EFS file system's [mount
/// targets](https://docs.aws.amazon.com/efs/latest/ug/accessing-fs.html).
pub const Ec2Config = struct {
    /// Specifies the Amazon Resource Names (ARNs) of the security groups associated
    /// with an
    /// Amazon EFS file system's mount target.
    security_group_arns: []const []const u8,

    /// Specifies the ARN of a subnet where DataSync creates the [network
    /// interfaces](https://docs.aws.amazon.com/datasync/latest/userguide/datasync-network.html#required-network-interfaces) for managing traffic during your transfer.
    ///
    /// The subnet must be located:
    ///
    /// * In the same virtual private cloud (VPC) as the Amazon EFS file system.
    ///
    /// * In the same Availability Zone as at least one mount target for the Amazon
    ///   EFS
    /// file system.
    ///
    /// You don't need to specify a subnet that includes a file system mount target.
    subnet_arn: []const u8,

    pub const json_field_names = .{
        .security_group_arns = "SecurityGroupArns",
        .subnet_arn = "SubnetArn",
    };
};
