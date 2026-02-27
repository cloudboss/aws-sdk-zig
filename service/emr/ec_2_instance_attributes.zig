/// Provides information about the Amazon EC2 instances in a cluster grouped by
/// category. For example, key name, subnet ID, IAM instance profile, and so
/// on.
pub const Ec2InstanceAttributes = struct {
    /// A list of additional Amazon EC2 security group IDs for the master node.
    additional_master_security_groups: ?[]const []const u8,

    /// A list of additional Amazon EC2 security group IDs for the core and task
    /// nodes.
    additional_slave_security_groups: ?[]const []const u8,

    /// The Availability Zone in which the cluster will run.
    ec_2_availability_zone: ?[]const u8,

    /// The name of the Amazon EC2 key pair to use when connecting with SSH into the
    /// master node as a user named "hadoop".
    ec_2_key_name: ?[]const u8,

    /// Set this parameter to the identifier of the Amazon VPC subnet where you want
    /// the
    /// cluster to launch. If you do not specify this value, and your account
    /// supports EC2-Classic,
    /// the cluster launches in EC2-Classic.
    ec_2_subnet_id: ?[]const u8,

    /// The identifier of the Amazon EC2 security group for the master node.
    emr_managed_master_security_group: ?[]const u8,

    /// The identifier of the Amazon EC2 security group for the core and task
    /// nodes.
    emr_managed_slave_security_group: ?[]const u8,

    /// The IAM role that was specified when the cluster was launched. The
    /// Amazon EC2 instances of the cluster assume this role.
    iam_instance_profile: ?[]const u8,

    /// Applies to clusters configured with the instance fleets option. Specifies
    /// one or more
    /// Availability Zones in which to launch Amazon EC2 cluster instances when the
    /// EC2-Classic network configuration is supported. Amazon EMR chooses the
    /// Availability
    /// Zone with the best fit from among the list of
    /// `RequestedEc2AvailabilityZones`,
    /// and then launches all cluster instances within that Availability Zone. If
    /// you do not
    /// specify this value, Amazon EMR chooses the Availability Zone for you.
    /// `RequestedEc2SubnetIDs` and `RequestedEc2AvailabilityZones` cannot
    /// be specified together.
    requested_ec_2_availability_zones: ?[]const []const u8,

    /// Applies to clusters configured with the instance fleets option. Specifies
    /// the unique
    /// identifier of one or more Amazon EC2 subnets in which to launch Amazon EC2
    /// cluster instances. Subnets must exist within the same VPC. Amazon EMR
    /// chooses the
    /// Amazon EC2 subnet with the best fit from among the list of
    /// `RequestedEc2SubnetIds`, and then launches all cluster instances within that
    /// Subnet. If this value is not specified, and the account and Region support
    /// EC2-Classic
    /// networks, the cluster launches instances in the EC2-Classic network and uses
    /// `RequestedEc2AvailabilityZones` instead of this setting. If EC2-Classic is
    /// not supported, and no Subnet is specified, Amazon EMR chooses the subnet for
    /// you.
    /// `RequestedEc2SubnetIDs` and `RequestedEc2AvailabilityZones` cannot
    /// be specified together.
    requested_ec_2_subnet_ids: ?[]const []const u8,

    /// The identifier of the Amazon EC2 security group for the Amazon EMR
    /// service to access clusters in VPC private subnets.
    service_access_security_group: ?[]const u8,

    pub const json_field_names = .{
        .additional_master_security_groups = "AdditionalMasterSecurityGroups",
        .additional_slave_security_groups = "AdditionalSlaveSecurityGroups",
        .ec_2_availability_zone = "Ec2AvailabilityZone",
        .ec_2_key_name = "Ec2KeyName",
        .ec_2_subnet_id = "Ec2SubnetId",
        .emr_managed_master_security_group = "EmrManagedMasterSecurityGroup",
        .emr_managed_slave_security_group = "EmrManagedSlaveSecurityGroup",
        .iam_instance_profile = "IamInstanceProfile",
        .requested_ec_2_availability_zones = "RequestedEc2AvailabilityZones",
        .requested_ec_2_subnet_ids = "RequestedEc2SubnetIds",
        .service_access_security_group = "ServiceAccessSecurityGroup",
    };
};
