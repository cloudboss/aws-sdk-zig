const InstanceGroupDetail = @import("instance_group_detail.zig").InstanceGroupDetail;
const PlacementType = @import("placement_type.zig").PlacementType;

/// Specify the type of Amazon EC2 instances that the cluster (job flow) runs
/// on.
pub const JobFlowInstancesDetail = struct {
    /// The name of an Amazon EC2 key pair that can be used to connect to the master
    /// node using SSH.
    ec_2_key_name: ?[]const u8 = null,

    /// For clusters launched within Amazon Virtual Private Cloud, this is the
    /// identifier of the
    /// subnet where the cluster was launched.
    ec_2_subnet_id: ?[]const u8 = null,

    /// The Hadoop version for the cluster.
    hadoop_version: ?[]const u8 = null,

    /// The number of Amazon EC2 instances in the cluster. If the value is 1, the
    /// same
    /// instance serves as both the master and core and task node. If the value is
    /// greater than 1,
    /// one instance is the master node and all others are core and task nodes.
    instance_count: i32,

    /// Details about the instance groups in a cluster.
    instance_groups: ?[]const InstanceGroupDetail = null,

    /// Specifies whether the cluster should remain available after completing all
    /// steps.
    keep_job_flow_alive_when_no_steps: ?bool = null,

    /// The Amazon EC2 instance identifier of the master node.
    master_instance_id: ?[]const u8 = null,

    /// The Amazon EC2 master node instance type.
    master_instance_type: []const u8,

    /// The DNS name of the master node. If the cluster is on a private subnet, this
    /// is the
    /// private DNS name. On a public subnet, this is the public DNS name.
    master_public_dns_name: ?[]const u8 = null,

    /// An approximation of the cost of the cluster, represented in m1.small/hours.
    /// This value
    /// is increased one time for every hour that an m1.small instance runs. Larger
    /// instances are
    /// weighted more heavily, so an Amazon EC2 instance that is roughly four times
    /// more
    /// expensive would result in the normalized instance hours being increased
    /// incrementally four
    /// times. This result is only an approximation and does not reflect the actual
    /// billing
    /// rate.
    normalized_instance_hours: ?i32 = null,

    /// The Amazon EC2 Availability Zone for the cluster.
    placement: ?PlacementType = null,

    /// The Amazon EC2 core and task node instance type.
    slave_instance_type: []const u8,

    /// Specifies whether the Amazon EC2 instances in the cluster are protected from
    /// termination by API calls, user intervention, or in the event of a job-flow
    /// error.
    termination_protected: ?bool = null,

    /// Indicates whether Amazon EMR should gracefully replace core nodes
    /// that have degraded within the cluster.
    unhealthy_node_replacement: ?bool = null,

    pub const json_field_names = .{
        .ec_2_key_name = "Ec2KeyName",
        .ec_2_subnet_id = "Ec2SubnetId",
        .hadoop_version = "HadoopVersion",
        .instance_count = "InstanceCount",
        .instance_groups = "InstanceGroups",
        .keep_job_flow_alive_when_no_steps = "KeepJobFlowAliveWhenNoSteps",
        .master_instance_id = "MasterInstanceId",
        .master_instance_type = "MasterInstanceType",
        .master_public_dns_name = "MasterPublicDnsName",
        .normalized_instance_hours = "NormalizedInstanceHours",
        .placement = "Placement",
        .slave_instance_type = "SlaveInstanceType",
        .termination_protected = "TerminationProtected",
        .unhealthy_node_replacement = "UnhealthyNodeReplacement",
    };
};
