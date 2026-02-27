const InstanceFleetConfig = @import("instance_fleet_config.zig").InstanceFleetConfig;
const InstanceGroupConfig = @import("instance_group_config.zig").InstanceGroupConfig;
const PlacementType = @import("placement_type.zig").PlacementType;

/// A description of the Amazon EC2 instance on which the cluster (job flow)
/// runs. A
/// valid JobFlowInstancesConfig must contain either InstanceGroups or
/// InstanceFleets. They
/// cannot be used together. You may also have MasterInstanceType,
/// SlaveInstanceType, and
/// InstanceCount (all three must be present), but we don't recommend this
/// configuration.
pub const JobFlowInstancesConfig = struct {
    /// A list of additional Amazon EC2 security group IDs for the master node.
    additional_master_security_groups: ?[]const []const u8,

    /// A list of additional Amazon EC2 security group IDs for the core and task
    /// nodes.
    additional_slave_security_groups: ?[]const []const u8,

    /// The name of the Amazon EC2 key pair that can be used to connect to the
    /// master
    /// node using SSH as the user called "hadoop."
    ec_2_key_name: ?[]const u8,

    /// Applies to clusters that use the uniform instance group configuration. To
    /// launch the
    /// cluster in Amazon Virtual Private Cloud (Amazon VPC), set this parameter to
    /// the
    /// identifier of the Amazon VPC subnet where you want the cluster to launch. If
    /// you do
    /// not specify this value and your account supports EC2-Classic, the cluster
    /// launches in
    /// EC2-Classic.
    ec_2_subnet_id: ?[]const u8,

    /// Applies to clusters that use the instance fleet configuration. When multiple
    /// Amazon EC2 subnet IDs are specified, Amazon EMR evaluates them and launches
    /// instances in the optimal subnet.
    ///
    /// The instance fleet configuration is available only in Amazon EMR releases
    /// 4.8.0 and later, excluding 5.0.x versions.
    ec_2_subnet_ids: ?[]const []const u8,

    /// The identifier of the Amazon EC2 security group for the master node. If you
    /// specify `EmrManagedMasterSecurityGroup`, you must also specify
    /// `EmrManagedSlaveSecurityGroup`.
    emr_managed_master_security_group: ?[]const u8,

    /// The identifier of the Amazon EC2 security group for the core and task nodes.
    /// If
    /// you specify `EmrManagedSlaveSecurityGroup`, you must also specify
    /// `EmrManagedMasterSecurityGroup`.
    emr_managed_slave_security_group: ?[]const u8,

    /// Applies only to Amazon EMR release versions earlier than 4.0. The Hadoop
    /// version
    /// for the cluster. Valid inputs are "0.18" (no longer maintained), "0.20" (no
    /// longer
    /// maintained), "0.20.205" (no longer maintained), "1.0.3", "2.2.0", or
    /// "2.4.0". If you do not
    /// set this value, the default of 0.18 is used, unless the `AmiVersion`
    /// parameter
    /// is set in the RunJobFlow call, in which case the default version of Hadoop
    /// for that AMI
    /// version is used.
    hadoop_version: ?[]const u8,

    /// The number of Amazon EC2 instances in the cluster.
    instance_count: ?i32,

    /// The instance fleet configuration is available only in Amazon EMR releases
    /// 4.8.0 and later, excluding 5.0.x versions.
    ///
    /// Describes the Amazon EC2 instances and instance configurations for clusters
    /// that
    /// use the instance fleet configuration.
    instance_fleets: ?[]const InstanceFleetConfig,

    /// Configuration for the instance groups in a cluster.
    instance_groups: ?[]const InstanceGroupConfig,

    /// Specifies whether the cluster should remain available after completing all
    /// steps.
    /// Defaults to `false`. For more information about configuring cluster
    /// termination,
    /// see [Control Cluster
    /// Termination](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-termination.html) in the *EMR Management
    /// Guide*.
    keep_job_flow_alive_when_no_steps: ?bool,

    /// The Amazon EC2 instance type of the master node.
    master_instance_type: ?[]const u8,

    /// The Availability Zone in which the cluster runs.
    placement: ?PlacementType,

    /// The identifier of the Amazon EC2 security group for the Amazon EMR
    /// service to access clusters in VPC private subnets.
    service_access_security_group: ?[]const u8,

    /// The Amazon EC2 instance type of the core and task nodes.
    slave_instance_type: ?[]const u8,

    /// Specifies whether to lock the cluster to prevent the Amazon EC2 instances
    /// from
    /// being terminated by API call, user intervention, or in the event of a
    /// job-flow
    /// error.
    termination_protected: ?bool,

    /// Indicates whether Amazon EMR should gracefully replace core nodes
    /// that have degraded within the cluster.
    unhealthy_node_replacement: ?bool,

    pub const json_field_names = .{
        .additional_master_security_groups = "AdditionalMasterSecurityGroups",
        .additional_slave_security_groups = "AdditionalSlaveSecurityGroups",
        .ec_2_key_name = "Ec2KeyName",
        .ec_2_subnet_id = "Ec2SubnetId",
        .ec_2_subnet_ids = "Ec2SubnetIds",
        .emr_managed_master_security_group = "EmrManagedMasterSecurityGroup",
        .emr_managed_slave_security_group = "EmrManagedSlaveSecurityGroup",
        .hadoop_version = "HadoopVersion",
        .instance_count = "InstanceCount",
        .instance_fleets = "InstanceFleets",
        .instance_groups = "InstanceGroups",
        .keep_job_flow_alive_when_no_steps = "KeepJobFlowAliveWhenNoSteps",
        .master_instance_type = "MasterInstanceType",
        .placement = "Placement",
        .service_access_security_group = "ServiceAccessSecurityGroup",
        .slave_instance_type = "SlaveInstanceType",
        .termination_protected = "TerminationProtected",
        .unhealthy_node_replacement = "UnhealthyNodeReplacement",
    };
};
