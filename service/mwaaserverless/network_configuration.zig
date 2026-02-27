/// Network configuration for workflow execution. Specifies VPC security groups
/// and subnets for secure network access. When provided, Amazon Managed
/// Workflows for Apache Airflow Serverless deploys ECS worker tasks in your
/// specified VPC configuration, enabling secure access to VPC-only resources.
/// The service uses a proxy API container architecture where one container
/// handles external communication while the worker container connects to your
/// VPC for task execution. This design provides both security isolation and
/// connectivity flexibility.
pub const NetworkConfiguration = struct {
    /// A list of VPC security group IDs to associate with the workflow execution
    /// environment.
    security_group_ids: ?[]const []const u8,

    /// A list of VPC subnet IDs where the workflow execution environment is
    /// deployed.
    subnet_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
