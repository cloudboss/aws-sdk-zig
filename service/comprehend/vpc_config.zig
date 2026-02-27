/// Configuration parameters for an optional private Virtual Private Cloud (VPC)
/// containing
/// the resources you are using for the job. For more information, see [Amazon
/// VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html).
pub const VpcConfig = struct {
    /// The ID number for a security group on an instance of your private VPC.
    /// Security groups on
    /// your VPC function serve as a virtual firewall to control inbound and
    /// outbound traffic and
    /// provides security for the resources that you’ll be accessing on the VPC.
    /// This ID number is
    /// preceded by "sg-", for instance: "sg-03b388029b0a285ea". For more
    /// information, see [Security
    /// Groups for your
    /// VPC](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html).
    security_group_ids: []const []const u8,

    /// The ID for each subnet being used in your private VPC. This subnet is a
    /// subset of the a
    /// range of IPv4 addresses used by the VPC and is specific to a given
    /// availability zone in the
    /// VPC’s Region. This ID number is preceded by "subnet-", for instance:
    /// "subnet-04ccf456919e69055". For more information, see [VPCs and
    /// Subnets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html).
    subnets: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnets = "Subnets",
    };
};
