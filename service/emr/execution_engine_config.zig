const ExecutionEngineType = @import("execution_engine_type.zig").ExecutionEngineType;

/// Specifies the execution engine (cluster) to run the notebook and perform the
/// notebook
/// execution, for example, an Amazon EMR cluster.
pub const ExecutionEngineConfig = struct {
    /// The execution role ARN required for the notebook execution.
    execution_role_arn: ?[]const u8,

    /// The unique identifier of the execution engine. For an Amazon EMR cluster,
    /// this
    /// is the cluster ID.
    id: []const u8,

    /// An optional unique ID of an Amazon EC2 security group to associate with the
    /// master instance of the Amazon EMR cluster for this notebook execution. For
    /// more
    /// information see [Specifying
    /// Amazon EC2 Security Groups for Amazon EMR
    /// Notebooks](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-managed-notebooks-security-groups.html) in the
    /// *EMR Management Guide*.
    master_instance_security_group_id: ?[]const u8,

    /// The type of execution engine. A value of `EMR` specifies an Amazon EMR
    /// cluster.
    @"type": ?ExecutionEngineType,

    pub const json_field_names = .{
        .execution_role_arn = "ExecutionRoleArn",
        .id = "Id",
        .master_instance_security_group_id = "MasterInstanceSecurityGroupId",
        .@"type" = "Type",
    };
};
