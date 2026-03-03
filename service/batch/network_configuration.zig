const AssignPublicIp = @import("assign_public_ip.zig").AssignPublicIp;

/// The network configuration for jobs that are running on Fargate resources.
/// Jobs that are
/// running on Amazon EC2 resources must not specify this parameter.
pub const NetworkConfiguration = struct {
    /// Indicates whether the job has a public IP address. For a job that's running
    /// on Fargate
    /// resources in a private subnet to send outbound traffic to the internet (for
    /// example, to pull
    /// container images), the private subnet requires a NAT gateway be attached to
    /// route requests to the
    /// internet. For more information, see [Amazon ECS task
    /// networking](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html) in the
    /// *Amazon Elastic Container Service Developer Guide*. The default value is
    /// "`DISABLED`".
    assign_public_ip: ?AssignPublicIp = null,

    pub const json_field_names = .{
        .assign_public_ip = "assignPublicIp",
    };
};
